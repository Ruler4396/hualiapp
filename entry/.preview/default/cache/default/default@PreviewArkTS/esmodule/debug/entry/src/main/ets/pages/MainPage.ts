if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface MainPage_Params {
    currentIndex?: number;
    tabsController?: TabsController;
}
import CommonConstants from "@bundle:com.example.component/entry/ets/common/constants/CommonConstants";
import Home from "@bundle:com.example.component/entry/ets/view/Home";
import Setting from "@bundle:com.example.component/entry/ets/view/Setting";
class MainPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__currentIndex = new ObservedPropertySimplePU(CommonConstants.HOME_TAB_INDEX, this, "currentIndex");
        this.tabsController = new TabsController();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: MainPage_Params) {
        if (params.currentIndex !== undefined) {
            this.currentIndex = params.currentIndex;
        }
        if (params.tabsController !== undefined) {
            this.tabsController = params.tabsController;
        }
    }
    updateStateVars(params: MainPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentIndex.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentIndex.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    /**
     * 状态变量：当前选中的标签页索引。
     * 初始化为首页的索引。
     */
    private __currentIndex: ObservedPropertySimplePU<number>;
    get currentIndex() {
        return this.__currentIndex.get();
    }
    set currentIndex(newValue: number) {
        this.__currentIndex.set(newValue);
    }
    /**
     * 私有变量：TabsController 实例，用于控制标签页的切换。
     */
    private tabsController: TabsController;
    /**
     * 构建器：创建自定义的标签栏。
     * @param title 标签标题。
     * @param index 标签索引。
     * @param selectedImg 选中状态的图标。
     * @param normalImg 正常状态的图标。
     */
    TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/MainPage.ets(57:5)", "entry");
            Column.justifyContent(FlexAlign.Center);
            Column.height({ "id": 16777315, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Column.width(CommonConstants.FULL_PARENT);
            Column.onClick(() => {
                this.currentIndex = index; // 更新当前选中的索引
                this.tabsController.changeIndex(this.currentIndex); // 切换到选中的标签页
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 显示图标：根据当前索引决定显示选中或正常状态的图标
            Image.create(this.currentIndex === index ? selectedImg : normalImg);
            Image.debugLine("entry/src/main/ets/pages/MainPage.ets(59:7)", "entry");
            // 显示图标：根据当前索引决定显示选中或正常状态的图标
            Image.width({ "id": 16777317, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 显示图标：根据当前索引决定显示选中或正常状态的图标
            Image.height({ "id": 16777317, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 显示标题文本
            Text.create(title);
            Text.debugLine("entry/src/main/ets/pages/MainPage.ets(64:7)", "entry");
            // 显示标题文本
            Text.margin({ top: { "id": 16777318, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            // 显示标题文本
            Text.fontSize({ "id": 16777322, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 显示标题文本
            Text.fontColor(this.currentIndex === index ? { "id": 16777377, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" } : { "id": 16777376, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Text);
        // 显示标题文本
        Text.pop();
        Column.pop();
    }
    /**
     * 构建页面 UI。
     */
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Tabs.create({
                barPosition: BarPosition.End,
                controller: this.tabsController // 使用控制器管理标签页切换
            });
            Tabs.debugLine("entry/src/main/ets/pages/MainPage.ets(83:5)", "entry");
            Tabs.width(CommonConstants.FULL_PARENT);
            Tabs.backgroundColor(Color.White);
            Tabs.barHeight({ "id": 16777315, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Tabs.barMode(BarMode.Fixed);
            Tabs.onChange((index: number) => {
                this.currentIndex = index; // 更新当前选中的索引
            });
        }, Tabs);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new Home(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/MainPage.ets", line: 89, col: 9 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "Home" });
                }
            });
            TabContent.padding({ left: { "id": 16777319, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, right: { "id": 16777319, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            TabContent.backgroundColor({ "id": 16777375, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, CommonConstants.HOME_TITLE, CommonConstants.HOME_TAB_INDEX, { "id": 16777389, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777358, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                } });
            TabContent.debugLine("entry/src/main/ets/pages/MainPage.ets(88:7)", "entry");
        }, TabContent);
        TabContent.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new Setting(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/MainPage.ets", line: 99, col: 9 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "Setting" });
                }
            });
            TabContent.padding({ left: { "id": 16777319, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, right: { "id": 16777319, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            TabContent.backgroundColor({ "id": 16777375, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, CommonConstants.MINE_TITLE, CommonConstants.MINE_TAB_INDEX, { "id": 16777393, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777356, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                } });
            TabContent.debugLine("entry/src/main/ets/pages/MainPage.ets(98:7)", "entry");
        }, TabContent);
        TabContent.pop();
        Tabs.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "MainPage";
    }
}
registerNamedRoute(() => new MainPage(undefined, {}), "", { bundleName: "com.example.component", moduleName: "entry", pagePath: "pages/MainPage", pageFullPath: "entry/src/main/ets/pages/MainPage", integratedHsp: "false", moduleType: "followWithHap" });
