import {BusinessError} from '@kit.BasicServicesKit';
import {ComponentContent,promptAction,UIContext} from '@kit.ArkUI';
import {hilog} from '@kit.PerformanceAnalysisKit';

class PromptActionClass{
  private ctx:UIContext|undefined=undefined;
  private contentNode: ComponentContent<Object>|undefined=undefined;
  private options:promptAction.BaseDialogOptions|undefined=undefined;

  setContext(context:UIContext){
    this.ctx=context;
  }

  setContentNode(node:ComponentContent<Object>){
    this.contentNode=node;
  }

  setOptions(options:promptAction.BaseDialogOptions){
    this.options=this.options;
  }

  openDialog(){
    if(this.contentNode!==null){
      this.ctx?.getPromptAction().openCustomDialog(this.contentNode,this.options)
        .then(()=>{
          hilog.info(0xFF00,'PersonalInformation','%{public}s','OpenCustomDialog complete');
        })
        .catch((error:BusinessError)=>{
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          hilog.error(0xFF00,'PersonalInformation','%{public}s',
            `OpenCustomDialog args error code is ${code},message is ${message}`);
        })
    }
  }
  closeDialog(){
    if (this.contentNode !== null){
      this.ctx?.getPromptAction().closeCustomDialog(this.contentNode)
        .then(()=>{
          hilog.info(0xFF00,'PersonalInformation','%{public}s','CloseCustomDialog complete')
        })
        .catch((error:BusinessError)=>{
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          hilog.error(0xFF00,'PersonalInformation','%{public}s',
          `CloseCustomDialog args error code is ${code},message is ${message}`);
        })
    }
  }

  updateDialog(options: Object){
    if (this.contentNode !== null){
      this.ctx?.getPromptAction().updateCustomDialog(this.contentNode,options)
        .then(()=> {
          hilog.info(0xFF00, 'PersonalInformation', '%{public}s', 'UpdateCustomDialog complete');
        })
        .catch((error:BusinessError)=> {
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          hilog.error(0xFF00, 'PersonalInformation', '%{public}s',
            `UpdateCustomDialog args error code is ${code},message is ${message}`);
        })
    }
  }
}

export default new PromptActionClass();