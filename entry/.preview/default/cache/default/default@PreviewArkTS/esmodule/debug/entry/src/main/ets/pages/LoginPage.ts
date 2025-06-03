if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface LoginPage_Params {
    account?: string;
    password?: string;
    isShowProgress?: boolean;
    timeOutId?: number;
}
import promptAction from "@ohos:promptAction";
import router from "@ohos:router";
import CommonConstants from "@bundle:com.example.component/entry/ets/common/constants/CommonConstants";
/**
 * 为 TextInput 组件扩展样式。
 * 定义了占位符颜色、高度、字体大小、背景色、宽度、边距等。
 */
function __TextInput__inputStyle(): void {
    TextInput.placeholderColor({ "id": 16777379, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
    TextInput.height({ "id": 16777306, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
    TextInput.fontSize({ "id": 16777280, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
    TextInput.backgroundColor({ "id": 16777368, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
    TextInput.width(CommonConstants.FULL_PARENT);
    TextInput.padding({ left: CommonConstants.INPUT_PADDING_LEFT });
    TextInput.margin({ top: { "id": 16777300, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
}
/**
 * 为 Line 组件扩展样式。
 * 定义了宽度、高度和背景色。
 */
function __Line__lineStyle(): void {
    Line.width(CommonConstants.FULL_PARENT);
    Line.height({ "id": 16777301, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
    Line.backgroundColor({ "id": 16777370, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
}
/**
 * 为 Text 组件扩展蓝色文本样式。
 * 定义了字体颜色、大小和粗细。
 */
function __Text__blueTextStyle(): void {
    Text.fontColor({ "id": 16777372, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
    Text.fontSize({ "id": 16777350, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
    Text.fontWeight(FontWeight.Medium);
}
class LoginPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__account = new ObservedPropertySimplePU('', this, "account");
        this.__password = new ObservedPropertySimplePU('', this, "password");
        this.__isShowProgress = new ObservedPropertySimplePU(false, this, "isShowProgress");
        this.timeOutId = -1;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: LoginPage_Params) {
        if (params.account !== undefined) {
            this.account = params.account;
        }
        if (params.password !== undefined) {
            this.password = params.password;
        }
        if (params.isShowProgress !== undefined) {
            this.isShowProgress = params.isShowProgress;
        }
        if (params.timeOutId !== undefined) {
            this.timeOutId = params.timeOutId;
        }
    }
    updateStateVars(params: LoginPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__account.purgeDependencyOnElmtId(rmElmtId);
        this.__password.purgeDependencyOnElmtId(rmElmtId);
        this.__isShowProgress.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__account.aboutToBeDeleted();
        this.__password.aboutToBeDeleted();
        this.__isShowProgress.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    /**
     * 状态变量：账户输入内容。
     */
    private __account: ObservedPropertySimplePU<string>; // 初始化账户为空字符串
    get account() {
        return this.__account.get();
    }
    set account(newValue: string) {
        this.__account.set(newValue);
    }
    /**
     * 状态变量：密码输入内容。
     */
    private __password: ObservedPropertySimplePU<string>; // 初始化密码为空字符串
    get password() {
        return this.__password.get();
    }
    set password(newValue: string) {
        this.__password.set(newValue);
    }
    /**
     * 状态变量：是否显示加载进度条。
     */
    private __isShowProgress: ObservedPropertySimplePU<boolean>; // 初始化不显示加载进度条
    get isShowProgress() {
        return this.__isShowProgress.get();
    }
    set isShowProgress(newValue: boolean) {
        this.__isShowProgress.set(newValue);
    }
    /**
     * 私有变量：定时器 ID，用于管理登录延迟。
     */
    private timeOutId: number; // 初始化定时器 ID 为 -1，表示未设置
    /**
     * 构建器：创建圆形图片按钮。
     * @param src 图片资源。
     */
    imageButton(src: Resource, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithChild({ type: ButtonType.Circle, stateEffect: true });
            Button.debugLine("entry/src/main/ets/pages/LoginPage.ets(99:5)", "entry");
            Button.height({ "id": 16777324, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Button.width({ "id": 16777324, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Button.backgroundColor({ "id": 16777368, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Button);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(src);
            Image.debugLine("entry/src/main/ets/pages/LoginPage.ets(100:7)", "entry");
        }, Image);
        Button.pop();
    }
    /**
     * 登录方法：处理登录逻辑。
     * 检查账户和密码是否为空，若不为空则显示加载进度条并模拟登录。
     */
    login(): void {
        if (this.account === '' || this.password === '') { // 如果账户或密码为空
            promptAction.showToast({
                message: { "id": 16777235, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" } // 提示内容为“输入为空”
            });
        }
        else { // 如果账户和密码均不为空
            if (this.account === '123' && this.password === '123456') { // 如果定时器未设置
                router.replaceUrl({ url: 'pages/MainPage' }); // 跳转到主页面
            }
            else {
                promptAction.showToast({
                    message: { "id": 16777402, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" } // 提示内容为“输入为空”
                });
            }
        }
    }
    /**
     * 页面即将消失时调用，清除定时器。
     */
    aboutToDisappear() {
        clearTimeout(this.timeOutId); // 清除定时器
        this.timeOutId = -1; // 重置定时器 ID
    }
    /**
     * 构建页面 UI。
     */
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/LoginPage.ets(141:5)", "entry");
            Column.backgroundColor({ "id": 16777368, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Column.height(CommonConstants.FULL_PARENT);
            Column.width(CommonConstants.FULL_PARENT);
            Column.padding({
                left: { "id": 16777327, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
                right: { "id": 16777327, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
                bottom: { "id": 16777309, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } // 下内边距
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Logo 图片
            Image.create({ "id": 16777398, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Image.debugLine("entry/src/main/ets/pages/LoginPage.ets(143:7)", "entry");
            // Logo 图片
            Image.width({ "id": 16777312, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // Logo 图片
            Image.height({ "id": 16777312, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // Logo 图片
            Image.margin({ top: { "id": 16777314, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, bottom: { "id": 16777313, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 页面标题
            Text.create({ "id": 16777400, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/LoginPage.ets(149:7)", "entry");
            // 页面标题
            Text.fontSize({ "id": 16777328, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 页面标题
            Text.fontWeight(FontWeight.Medium);
            // 页面标题
            Text.fontColor({ "id": 16777383, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Text);
        // 页面标题
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 副标题
            Text.create({ "id": 16777237, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/LoginPage.ets(155:7)", "entry");
            // 副标题
            Text.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 副标题
            Text.fontColor({ "id": 16777374, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 副标题
            Text.margin({ bottom: { "id": 16777307, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, top: { "id": 16777308, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Text);
        // 副标题
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 账户输入框
            TextInput.create({ placeholder: { "id": 16777225, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            TextInput.debugLine("entry/src/main/ets/pages/LoginPage.ets(161:7)", "entry");
            // 账户输入框
            TextInput.maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH);
            // 账户输入框
            TextInput.type(InputType.Number);
            __TextInput__inputStyle();
            // 账户输入框
            TextInput.onChange((value: string) => {
                this.account = value; // 更新账户状态变量
            });
        }, TextInput);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 分割线
            Line.create();
            Line.debugLine("entry/src/main/ets/pages/LoginPage.ets(169:7)", "entry");
            __Line__lineStyle();
        }, Line);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 密码输入框
            TextInput.create({ placeholder: { "id": 16777259, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            TextInput.debugLine("entry/src/main/ets/pages/LoginPage.ets(172:7)", "entry");
            // 密码输入框
            TextInput.maxLength(CommonConstants.INPUT_PASSWORD_LENGTH);
            // 密码输入框
            TextInput.type(InputType.Password);
            __TextInput__inputStyle();
            // 密码输入框
            TextInput.onChange((value: string) => {
                this.password = value; // 更新密码状态变量
            });
        }, TextInput);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 分割线
            Line.create();
            Line.debugLine("entry/src/main/ets/pages/LoginPage.ets(180:7)", "entry");
            __Line__lineStyle();
        }, Line);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 短信登录和忘记密码文本
            Row.create();
            Row.debugLine("entry/src/main/ets/pages/LoginPage.ets(183:7)", "entry");
            // 短信登录和忘记密码文本
            Row.justifyContent(FlexAlign.SpaceBetween);
            // 短信登录和忘记密码文本
            Row.width(CommonConstants.FULL_PARENT);
            // 短信登录和忘记密码文本
            Row.margin({ top: { "id": 16777281, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777252, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/LoginPage.ets(184:9)", "entry");
            __Text__blueTextStyle();
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777231, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/LoginPage.ets(185:9)", "entry");
            __Text__blueTextStyle();
        }, Text);
        Text.pop();
        // 短信登录和忘记密码文本
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 登录按钮
            Button.createWithLabel({ "id": 16777236, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { type: ButtonType.Capsule });
            Button.debugLine("entry/src/main/ets/pages/LoginPage.ets(192:7)", "entry");
            // 登录按钮
            Button.width(CommonConstants.BUTTON_WIDTH);
            // 登录按钮
            Button.height({ "id": 16777303, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 登录按钮
            Button.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 登录按钮
            Button.fontWeight(FontWeight.Medium);
            // 登录按钮
            Button.backgroundColor({ "id": 16777373, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 登录按钮
            Button.margin({ top: { "id": 16777305, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, bottom: { "id": 16777304, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            // 登录按钮
            Button.onClick(() => {
                this.login(); // 调用登录方法
            });
        }, Button);
        // 登录按钮
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 注册账户文本
            Text.create({ "id": 16777263, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/LoginPage.ets(204:7)", "entry");
            // 注册账户文本
            Text.fontColor({ "id": 16777372, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 注册账户文本
            Text.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 注册账户文本
            Text.fontWeight(FontWeight.Medium);
        }, Text);
        // 注册账户文本
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            // 如果 isShowProgress 为 true，显示加载进度条
            if (this.isShowProgress) { // 根据状态变量决定是否显示
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        LoadingProgress.create();
                        LoadingProgress.debugLine("entry/src/main/ets/pages/LoginPage.ets(211:9)", "entry");
                        LoadingProgress.color({ "id": 16777371, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        LoadingProgress.width({ "id": 16777311, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        LoadingProgress.height({ "id": 16777311, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        LoadingProgress.margin({ top: { "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
                    }, LoadingProgress);
                });
            }
            // 空白区域，填充剩余空间
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 空白区域，填充剩余空间
            Blank.create();
            Blank.debugLine("entry/src/main/ets/pages/LoginPage.ets(219:7)", "entry");
        }, Blank);
        // 空白区域，填充剩余空间
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 其他登录方式文本
            Text.create({ "id": 16777258, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/LoginPage.ets(222:7)", "entry");
            // 其他登录方式文本
            Text.fontColor({ "id": 16777378, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 其他登录方式文本
            Text.fontSize({ "id": 16777302, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 其他登录方式文本
            Text.fontWeight(FontWeight.Medium);
            // 其他登录方式文本
            Text.margin({ top: { "id": 16777326, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, bottom: { "id": 16777325, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Text);
        // 其他登录方式文本
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 其他登录方式的图片按钮
            Row.create({ space: CommonConstants.LOGIN_METHODS_SPACE });
            Row.debugLine("entry/src/main/ets/pages/LoginPage.ets(229:7)", "entry");
        }, Row);
        this.imageButton.bind(this)({ "id": 16777277, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }) // 创建第一个图片按钮
        ;
        this.imageButton.bind(this)({ "id": 16777279, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }) // 创建第二个图片按钮
        ;
        this.imageButton.bind(this)({ "id": 16777366, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }) // 创建第三个图片按钮
        ;
        // 其他登录方式的图片按钮
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "LoginPage";
    }
}
registerNamedRoute(() => new LoginPage(undefined, {}), "", { bundleName: "com.example.component", moduleName: "entry", pagePath: "pages/LoginPage", pageFullPath: "entry/src/main/ets/pages/LoginPage", integratedHsp: "false", moduleType: "followWithHap" });
