<?php /*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */ /** @noinspection PhpUnused */
namespace App\Http\Controllers\DataLab;
use App\DataTableServices\OAClientDataTableService;
use App\Http\Controllers\BaseDataLabController;
class OAClientController extends BaseDataLabController {
	public function index(OAClientDataTableService $dataTable){
		return $dataTable->render(qm_request()->getViewPathByType('index'));
	}
	public function create(){
		return parent::create();
	}
	public function store(){
		return parent::store();
	}
	public function show($id){
		return parent::show($id);
	}
	public function edit($id){
		return parent::edit($id);
	}
	public function destroy($id){
		return parent::destroy($id);
	}
}
