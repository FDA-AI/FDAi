/*!
*
* Copyright 2009-2012 Kris Kowal under the terms of the MIT
* license found at http://github.com/kriskowal/q/raw/master/LICENSE
*
* With parts by Tyler Close
* Copyright 2007-2009 Tyler Close under the terms of the MIT X license found
* at http://www.opensource.org/licenses/mit-license.html
* Forked at ref_send.js version: 2009-05-11
*
* With parts by Mark Miller
* Copyright (C) 2011 Google Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
*/(function(definition){if(typeof bootstrap==="function"){bootstrap("promise",definition);}else if(typeof exports==="object"){module.exports=definition();}else if(typeof define==="function"&&define.amd){define(definition);}else if(typeof ses!=="undefined"){if(!ses.ok()){return;}else{ses.makeQ=definition;}}else{Q=definition();}})(function(){"use strict";var hasStacks=false;try{throw new Error();}catch(e){hasStacks=!!e.stack;}
var qStartingLine=captureLine();var qFileName;var noop=function(){};var nextTick=(function(){var head={task:void 0,next:null};var tail=head;var flushing=false;var requestTick=void 0;var isNodeJS=false;function flush(){while(head.next){head=head.next;var task=head.task;head.task=void 0;var domain=head.domain;if(domain){head.domain=void 0;domain.enter();}
try{task();}catch(e){if(isNodeJS){if(domain){domain.exit();}
setTimeout(flush,0);if(domain){domain.enter();}
throw e;}else{setTimeout(function(){throw e;},0);}}
if(domain){domain.exit();}}
flushing=false;}
nextTick=function(task){tail=tail.next={task:task,domain:isNodeJS&&process.domain,next:null};if(!flushing){flushing=true;requestTick();}};if(typeof process!=="undefined"&&process.nextTick){isNodeJS=true;requestTick=function(){process.nextTick(flush);};}else if(typeof setImmediate==="function"){if(typeof window!=="undefined"){requestTick=setImmediate.bind(window,flush);}else{requestTick=function(){setImmediate(flush);};}}else if(typeof MessageChannel!=="undefined"){var channel=new MessageChannel();channel.port1.onmessage=function(){requestTick=requestPortTick;channel.port1.onmessage=flush;flush();};var requestPortTick=function(){channel.port2.postMessage(0);};requestTick=function(){setTimeout(flush,0);requestPortTick();};}else{requestTick=function(){setTimeout(flush,0);};}
return nextTick;})();var call=Function.call;function uncurryThis(f){return function(){return call.apply(f,arguments);};}
var array_slice=uncurryThis(Array.prototype.slice);var array_reduce=uncurryThis(Array.prototype.reduce||function(callback,basis){var index=0,length=this.length;if(arguments.length===1){do{if(index in this){basis=this[index++];break;}
if(++index>=length){throw new TypeError();}}while(1);}
for(;index<length;index++){if(index in this){basis=callback(basis,this[index],index);}}
return basis;});var array_indexOf=uncurryThis(Array.prototype.indexOf||function(value){for(var i=0;i<this.length;i++){if(this[i]===value){return i;}}
return-1;});var array_map=uncurryThis(Array.prototype.map||function(callback,thisp){var self=this;var collect=[];array_reduce(self,function(undefined,value,index){collect.push(callback.call(thisp,value,index,self));},void 0);return collect;});var object_create=Object.create||function(prototype){function Type(){}
Type.prototype=prototype;return new Type();};var object_hasOwnProperty=uncurryThis(Object.prototype.hasOwnProperty);var object_keys=Object.keys||function(object){var keys=[];for(var key in object){if(object_hasOwnProperty(object,key)){keys.push(key);}}
return keys;};var object_toString=uncurryThis(Object.prototype.toString);function isObject(value){return value===Object(value);}
function isStopIteration(exception){return(object_toString(exception)==="[object StopIteration]"||exception instanceof QReturnValue);}
var QReturnValue;if(typeof ReturnValue!=="undefined"){QReturnValue=ReturnValue;}else{QReturnValue=function(value){this.value=value;};}
var STACK_JUMP_SEPARATOR="From previous event:";function makeStackTraceLong(error,promise){if(hasStacks&&promise.stack&&typeof error==="object"&&error!==null&&error.stack&&error.stack.indexOf(STACK_JUMP_SEPARATOR)===-1){var stacks=[];for(var p=promise;!!p;p=p.source){if(p.stack){stacks.unshift(p.stack);}}
stacks.unshift(error.stack);var concatedStacks=stacks.join("\n"+STACK_JUMP_SEPARATOR+"\n");error.stack=filterStackString(concatedStacks);}}
function filterStackString(stackString){var lines=stackString.split("\n");var desiredLines=[];for(var i=0;i<lines.length;++i){var line=lines[i];if(!isInternalFrame(line)&&!isNodeFrame(line)&&line){desiredLines.push(line);}}
return desiredLines.join("\n");}
function isNodeFrame(stackLine){return stackLine.indexOf("(module.js:")!==-1||stackLine.indexOf("(node.js:")!==-1;}
function getFileNameAndLineNumber(stackLine){var attempt1=/at .+ \((.+):(\d+):(?:\d+)\)$/.exec(stackLine);if(attempt1){return[attempt1[1],Number(attempt1[2])];}
var attempt2=/at ([^ ]+):(\d+):(?:\d+)$/.exec(stackLine);if(attempt2){return[attempt2[1],Number(attempt2[2])];}
var attempt3=/.*@(.+):(\d+)$/.exec(stackLine);if(attempt3){return[attempt3[1],Number(attempt3[2])];}}
function isInternalFrame(stackLine){var fileNameAndLineNumber=getFileNameAndLineNumber(stackLine);if(!fileNameAndLineNumber){return false;}
var fileName=fileNameAndLineNumber[0];var lineNumber=fileNameAndLineNumber[1];return fileName===qFileName&&lineNumber>=qStartingLine&&lineNumber<=qEndingLine;}
function captureLine(){if(!hasStacks){return;}
try{throw new Error();}catch(e){var lines=e.stack.split("\n");var firstLine=lines[0].indexOf("@")>0?lines[1]:lines[2];var fileNameAndLineNumber=getFileNameAndLineNumber(firstLine);if(!fileNameAndLineNumber){return;}
qFileName=fileNameAndLineNumber[0];return fileNameAndLineNumber[1];}}
function deprecate(callback,name,alternative){return function(){if(typeof console!=="undefined"&&typeof console.warn==="function"){console.warn(name+" is deprecated, use "+alternative+
" instead.",new Error("").stack);}
return callback.apply(callback,arguments);};}
function Q(value){if(isPromise(value)){return value;}
if(isPromiseAlike(value)){return coerce(value);}else{return fulfill(value);}}
Q.resolve=Q;Q.nextTick=nextTick;Q.longStackSupport=false;Q.defer=defer;function defer(){var messages=[],progressListeners=[],resolvedPromise;var deferred=object_create(defer.prototype);var promise=object_create(Promise.prototype);promise.promiseDispatch=function(resolve,op,operands){var args=array_slice(arguments);if(messages){messages.push(args);if(op==="when"&&operands[1]){progressListeners.push(operands[1]);}}else{nextTick(function(){resolvedPromise.promiseDispatch.apply(resolvedPromise,args);});}};promise.valueOf=function(){if(messages){return promise;}
var nearerValue=nearer(resolvedPromise);if(isPromise(nearerValue)){resolvedPromise=nearerValue;}
return nearerValue;};promise.inspect=function(){if(!resolvedPromise){return{state:"pending"};}
return resolvedPromise.inspect();};if(Q.longStackSupport&&hasStacks){try{throw new Error();}catch(e){promise.stack=e.stack.substring(e.stack.indexOf("\n")+1);}}
function become(newPromise){resolvedPromise=newPromise;promise.source=newPromise;array_reduce(messages,function(undefined,message){nextTick(function(){newPromise.promiseDispatch.apply(newPromise,message);});},void 0);messages=void 0;progressListeners=void 0;}
deferred.promise=promise;deferred.resolve=function(value){if(resolvedPromise){return;}
become(Q(value));};deferred.fulfill=function(value){if(resolvedPromise){return;}
become(fulfill(value));};deferred.reject=function(reason){if(resolvedPromise){return;}
become(reject(reason));};deferred.notify=function(progress){if(resolvedPromise){return;}
array_reduce(progressListeners,function(undefined,progressListener){nextTick(function(){progressListener(progress);});},void 0);};return deferred;}
defer.prototype.makeNodeResolver=function(){var self=this;return function(error,value){if(error){self.reject(error);}else if(arguments.length>2){self.resolve(array_slice(arguments,1));}else{self.resolve(value);}};};Q.Promise=promise;Q.promise=promise;function promise(resolver){if(typeof resolver!=="function"){throw new TypeError("resolver must be a function.");}
var deferred=defer();try{resolver(deferred.resolve,deferred.reject,deferred.notify);}catch(reason){deferred.reject(reason);}
return deferred.promise;}
promise.race=race;promise.all=all;promise.reject=reject;promise.resolve=Q;Q.passByCopy=function(object){return object;};Promise.prototype.passByCopy=function(){return this;};Q.join=function(x,y){return Q(x).join(y);};Promise.prototype.join=function(that){return Q([this,that]).spread(function(x,y){if(x===y){return x;}else{throw new Error("Can't join: not the same: "+x+" "+y);}});};Q.race=race;function race(answerPs){return promise(function(resolve,reject){for(var i=0,len=answerPs.length;i<len;i++){Q(answerPs[i]).then(resolve,reject);}});}
Promise.prototype.race=function(){return this.then(Q.race);};Q.makePromise=Promise;function Promise(descriptor,fallback,inspect){if(fallback===void 0){fallback=function(op){return reject(new Error("Promise does not support operation: "+op));};}
if(inspect===void 0){inspect=function(){return{state:"unknown"};};}
var promise=object_create(Promise.prototype);promise.promiseDispatch=function(resolve,op,args){var result;try{if(descriptor[op]){result=descriptor[op].apply(promise,args);}else{result=fallback.call(promise,op,args);}}catch(exception){result=reject(exception);}
if(resolve){resolve(result);}};promise.inspect=inspect;if(inspect){var inspected=inspect();if(inspected.state==="rejected"){promise.exception=inspected.reason;}
promise.valueOf=function(){var inspected=inspect();if(inspected.state==="pending"||inspected.state==="rejected"){return promise;}
return inspected.value;};}
return promise;}
Promise.prototype.toString=function(){return "[object Promise]";};Promise.prototype.then=function(fulfilled,rejected,progressed){var self=this;var deferred=defer();var done=false;function _fulfilled(value){try{return typeof fulfilled==="function"?fulfilled(value):value;}catch(exception){return reject(exception);}}
function _rejected(exception){if(typeof rejected==="function"){makeStackTraceLong(exception,self);try{return rejected(exception);}catch(newException){return reject(newException);}}
return reject(exception);}
function _progressed(value){return typeof progressed==="function"?progressed(value):value;}
nextTick(function(){self.promiseDispatch(function(value){if(done){return;}
done=true;deferred.resolve(_fulfilled(value));},"when",[function(exception){if(done){return;}
done=true;deferred.resolve(_rejected(exception));}]);});self.promiseDispatch(void 0,"when",[void 0,function(value){var newValue;var threw=false;try{newValue=_progressed(value);}catch(e){threw=true;if(Q.onerror){Q.onerror(e);}else{throw e;}}
if(!threw){deferred.notify(newValue);}}]);return deferred.promise;};Q.when=when;function when(value,fulfilled,rejected,progressed){return Q(value).then(fulfilled,rejected,progressed);}
Promise.prototype.thenResolve=function(value){return this.then(function(){return value;});};Q.thenResolve=function(promise,value){return Q(promise).thenResolve(value);};Promise.prototype.thenReject=function(reason){return this.then(function(){throw reason;});};Q.thenReject=function(promise,reason){return Q(promise).thenReject(reason);};Q.nearer=nearer;function nearer(value){if(isPromise(value)){var inspected=value.inspect();if(inspected.state==="fulfilled"){return inspected.value;}}
return value;}
Q.isPromise=isPromise;function isPromise(object){return isObject(object)&&typeof object.promiseDispatch==="function"&&typeof object.inspect==="function";}
Q.isPromiseAlike=isPromiseAlike;function isPromiseAlike(object){return isObject(object)&&typeof object.then==="function";}
Q.isPending=isPending;function isPending(object){return isPromise(object)&&object.inspect().state==="pending";}
Promise.prototype.isPending=function(){return this.inspect().state==="pending";};Q.isFulfilled=isFulfilled;function isFulfilled(object){return!isPromise(object)||object.inspect().state==="fulfilled";}
Promise.prototype.isFulfilled=function(){return this.inspect().state==="fulfilled";};Q.isRejected=isRejected;function isRejected(object){return isPromise(object)&&object.inspect().state==="rejected";}
Promise.prototype.isRejected=function(){return this.inspect().state==="rejected";};var unhandledReasons=[];var unhandledRejections=[];var trackUnhandledRejections=true;function resetUnhandledRejections(){unhandledReasons.length=0;unhandledRejections.length=0;if(!trackUnhandledRejections){trackUnhandledRejections=true;}}
function trackRejection(promise,reason){if(!trackUnhandledRejections){return;}
unhandledRejections.push(promise);if(reason&&typeof reason.stack!=="undefined"){unhandledReasons.push(reason.stack);}else{unhandledReasons.push("(no stack) "+reason);}}
function untrackRejection(promise){if(!trackUnhandledRejections){return;}
var at=array_indexOf(unhandledRejections,promise);if(at!==-1){unhandledRejections.splice(at,1);unhandledReasons.splice(at,1);}}
Q.resetUnhandledRejections=resetUnhandledRejections;Q.getUnhandledReasons=function(){return unhandledReasons.slice();};Q.stopUnhandledRejectionTracking=function(){resetUnhandledRejections();trackUnhandledRejections=false;};resetUnhandledRejections();Q.reject=reject;function reject(reason){var rejection=Promise({"when":function(rejected){if(rejected){untrackRejection(this);}
return rejected?rejected(reason):this;}},function fallback(){return this;},function inspect(){return{state:"rejected",reason:reason};});trackRejection(rejection,reason);return rejection;}
Q.fulfill=fulfill;function fulfill(value){return Promise({"when":function(){return value;},"get":function(name){return value[name];},"set":function(name,rhs){value[name]=rhs;},"delete":function(name){delete value[name];},"post":function(name,args){if(name===null||name===void 0){return value.apply(void 0,args);}else{return value[name].apply(value,args);}},"apply":function(thisp,args){return value.apply(thisp,args);},"keys":function(){return object_keys(value);}},void 0,function inspect(){return{state:"fulfilled",value:value};});}
function coerce(promise){var deferred=defer();nextTick(function(){try{promise.then(deferred.resolve,deferred.reject,deferred.notify);}catch(exception){deferred.reject(exception);}});return deferred.promise;}
Q.master=master;function master(object){return Promise({"isDef":function(){}},function fallback(op,args){return dispatch(object,op,args);},function(){return Q(object).inspect();});}
Q.spread=spread;function spread(value,fulfilled,rejected){return Q(value).spread(fulfilled,rejected);}
Promise.prototype.spread=function(fulfilled,rejected){return this.all().then(function(array){return fulfilled.apply(void 0,array);},rejected);};Q.async=async;function async(makeGenerator){return function(){function continuer(verb,arg){var result;if(typeof StopIteration==="undefined"){try{result=generator[verb](arg);}catch(exception){return reject(exception);}
if(result.done){return result.value;}else{return when(result.value,callback,errback);}}else{try{result=generator[verb](arg);}catch(exception){if(isStopIteration(exception)){return exception.value;}else{return reject(exception);}}
return when(result,callback,errback);}}
var generator=makeGenerator.apply(this,arguments);var callback=continuer.bind(continuer,"next");var errback=continuer.bind(continuer,"throw");return callback();};}
Q.spawn=spawn;function spawn(makeGenerator){Q.done(Q.async(makeGenerator)());}
Q["return"]=_return;function _return(value){throw new QReturnValue(value);}
Q.promised=promised;function promised(callback){return function(){return spread([this,all(arguments)],function(self,args){return callback.apply(self,args);});};}
Q.dispatch=dispatch;function dispatch(object,op,args){return Q(object).dispatch(op,args);}
Promise.prototype.dispatch=function(op,args){var self=this;var deferred=defer();nextTick(function(){self.promiseDispatch(deferred.resolve,op,args);});return deferred.promise;};Q.get=function(object,key){return Q(object).dispatch("get",[key]);};Promise.prototype.get=function(key){return this.dispatch("get",[key]);};Q.set=function(object,key,value){return Q(object).dispatch("set",[key,value]);};Promise.prototype.set=function(key,value){return this.dispatch("set",[key,value]);};Q.del=Q["delete"]=function(object,key){return Q(object).dispatch("delete",[key]);};Promise.prototype.del=Promise.prototype["delete"]=function(key){return this.dispatch("delete",[key]);};Q.mapply=Q.post=function(object,name,args){return Q(object).dispatch("post",[name,args]);};Promise.prototype.mapply=Promise.prototype.post=function(name,args){return this.dispatch("post",[name,args]);};Q.send=Q.mcall=Q.invoke=function(object,name){return Q(object).dispatch("post",[name,array_slice(arguments,2)]);};Promise.prototype.send=Promise.prototype.mcall=Promise.prototype.invoke=function(name){return this.dispatch("post",[name,array_slice(arguments,1)]);};Q.fapply=function(object,args){return Q(object).dispatch("apply",[void 0,args]);};Promise.prototype.fapply=function(args){return this.dispatch("apply",[void 0,args]);};Q["try"]=Q.fcall=function(object){return Q(object).dispatch("apply",[void 0,array_slice(arguments,1)]);};Promise.prototype.fcall=function(){return this.dispatch("apply",[void 0,array_slice(arguments)]);};Q.fbind=function(object){var promise=Q(object);var args=array_slice(arguments,1);return function fbound(){return promise.dispatch("apply",[this,args.concat(array_slice(arguments))]);};};Promise.prototype.fbind=function(){var promise=this;var args=array_slice(arguments);return function fbound(){return promise.dispatch("apply",[this,args.concat(array_slice(arguments))]);};};Q.keys=function(object){return Q(object).dispatch("keys",[]);};Promise.prototype.keys=function(){return this.dispatch("keys",[]);};Q.all=all;function all(promises){return when(promises,function(promises){var countDown=0;var deferred=defer();array_reduce(promises,function(undefined,promise,index){var snapshot;if(isPromise(promise)&&(snapshot=promise.inspect()).state==="fulfilled"){promises[index]=snapshot.value;}else{++countDown;when(promise,function(value){promises[index]=value;if(--countDown===0){deferred.resolve(promises);}},deferred.reject,function(progress){deferred.notify({index:index,value:progress});});}},void 0);if(countDown===0){deferred.resolve(promises);}
return deferred.promise;});}
Promise.prototype.all=function(){return all(this);};Q.allResolved=deprecate(allResolved,"allResolved","allSettled");function allResolved(promises){return when(promises,function(promises){promises=array_map(promises,Q);return when(all(array_map(promises,function(promise){return when(promise,noop,noop);})),function(){return promises;});});}
Promise.prototype.allResolved=function(){return allResolved(this);};Q.allSettled=allSettled;function allSettled(promises){return Q(promises).allSettled();}
Promise.prototype.allSettled=function(){return this.then(function(promises){return all(array_map(promises,function(promise){promise=Q(promise);function regardless(){return promise.inspect();}
return promise.then(regardless,regardless);}));});};Q.fail=Q["catch"]=function(object,rejected){return Q(object).then(void 0,rejected);};Promise.prototype.fail=Promise.prototype["catch"]=function(rejected){return this.then(void 0,rejected);};Q.progress=progress;function progress(object,progressed){return Q(object).then(void 0,void 0,progressed);}
Promise.prototype.progress=function(progressed){return this.then(void 0,void 0,progressed);};Q.fin=Q["finally"]=function(object,callback){return Q(object)["finally"](callback);};Promise.prototype.fin=Promise.prototype["finally"]=function(callback){callback=Q(callback);return this.then(function(value){return callback.fcall().then(function(){return value;});},function(reason){return callback.fcall().then(function(){throw reason;});});};Q.done=function(object,fulfilled,rejected,progress){return Q(object).done(fulfilled,rejected,progress);};Promise.prototype.done=function(fulfilled,rejected,progress){var onUnhandledError=function(error){nextTick(function(){makeStackTraceLong(error,promise);if(Q.onerror){Q.onerror(error);}else{throw error;}});};var promise=fulfilled||rejected||progress?this.then(fulfilled,rejected,progress):this;if(typeof process==="object"&&process&&process.domain){onUnhandledError=process.domain.bind(onUnhandledError);}
promise.then(void 0,onUnhandledError);};Q.timeout=function(object,ms,message){return Q(object).timeout(ms,message);};Promise.prototype.timeout=function(ms,message){var deferred=defer();var timeoutId=setTimeout(function(){deferred.reject(new Error(message||"Timed out after "+ms+" ms"));},ms);this.then(function(value){clearTimeout(timeoutId);deferred.resolve(value);},function(exception){clearTimeout(timeoutId);deferred.reject(exception);},deferred.notify);return deferred.promise;};Q.delay=function(object,timeout){if(timeout===void 0){timeout=object;object=void 0;}
return Q(object).delay(timeout);};Promise.prototype.delay=function(timeout){return this.then(function(value){var deferred=defer();setTimeout(function(){deferred.resolve(value);},timeout);return deferred.promise;});};Q.nfapply=function(callback,args){return Q(callback).nfapply(args);};Promise.prototype.nfapply=function(args){var deferred=defer();var nodeArgs=array_slice(args);nodeArgs.push(deferred.makeNodeResolver());this.fapply(nodeArgs).fail(deferred.reject);return deferred.promise;};Q.nfcall=function(callback){var args=array_slice(arguments,1);return Q(callback).nfapply(args);};Promise.prototype.nfcall=function(){var nodeArgs=array_slice(arguments);var deferred=defer();nodeArgs.push(deferred.makeNodeResolver());this.fapply(nodeArgs).fail(deferred.reject);return deferred.promise;};Q.nfbind=Q.denodeify=function(callback){var baseArgs=array_slice(arguments,1);return function(){var nodeArgs=baseArgs.concat(array_slice(arguments));var deferred=defer();nodeArgs.push(deferred.makeNodeResolver());Q(callback).fapply(nodeArgs).fail(deferred.reject);return deferred.promise;};};Promise.prototype.nfbind=Promise.prototype.denodeify=function(){var args=array_slice(arguments);args.unshift(this);return Q.denodeify.apply(void 0,args);};Q.nbind=function(callback,thisp){var baseArgs=array_slice(arguments,2);return function(){var nodeArgs=baseArgs.concat(array_slice(arguments));var deferred=defer();nodeArgs.push(deferred.makeNodeResolver());function bound(){return callback.apply(thisp,arguments);}
Q(bound).fapply(nodeArgs).fail(deferred.reject);return deferred.promise;};};Promise.prototype.nbind=function(){var args=array_slice(arguments,0);args.unshift(this);return Q.nbind.apply(void 0,args);};Q.nmapply=Q.npost=function(object,name,args){return Q(object).npost(name,args);};Promise.prototype.nmapply=Promise.prototype.npost=function(name,args){var nodeArgs=array_slice(args||[]);var deferred=defer();nodeArgs.push(deferred.makeNodeResolver());this.dispatch("post",[name,nodeArgs]).fail(deferred.reject);return deferred.promise;};Q.nsend=Q.nmcall=Q.ninvoke=function(object,name){var nodeArgs=array_slice(arguments,2);var deferred=defer();nodeArgs.push(deferred.makeNodeResolver());Q(object).dispatch("post",[name,nodeArgs]).fail(deferred.reject);return deferred.promise;};Promise.prototype.nsend=Promise.prototype.nmcall=Promise.prototype.ninvoke=function(name){var nodeArgs=array_slice(arguments,1);var deferred=defer();nodeArgs.push(deferred.makeNodeResolver());this.dispatch("post",[name,nodeArgs]).fail(deferred.reject);return deferred.promise;};Q.nodeify=nodeify;function nodeify(object,nodeback){return Q(object).nodeify(nodeback);}
Promise.prototype.nodeify=function(nodeback){if(nodeback){this.then(function(value){nextTick(function(){nodeback(null,value);});},function(error){nextTick(function(){nodeback(error);});});}else{return this;}};var qEndingLine=captureLine();return Q;});