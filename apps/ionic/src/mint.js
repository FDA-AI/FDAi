$(document).ready(async function() {
	debugger
	await LitJsSdk.litJsSdkLoadedInALIT()
	// your page initialization code here the DOM will be available here
	const result = await qm.web3.encrypt();
	console.log(result);
	
});
