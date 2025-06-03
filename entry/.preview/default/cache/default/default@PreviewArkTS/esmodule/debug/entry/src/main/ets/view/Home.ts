if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Home_Params {
    swiperController?: SwiperController;
}
import CommonConstants from "@bundle:com.example.component/entry/ets/common/constants/CommonConstants";
import mainViewModel from "@bundle:com.example.component/entry/ets/viewmodel/MainViewModel";
import type ItemData from '../viewmodel/ItemData';
export default class Home extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.swiperController = new SwiperController();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Home_Params) {
        if (params.swiperController !== undefined) {
            this.swiperController = params.swiperController;
        }
    }
    updateStateVars(params: Home_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    /**
     * 私有变量：SwiperController 实例，用于控制轮播图的切换。
     */
    private swiperController: SwiperController;
    /**
     * 构建页面 UI。
     * build() 方法定义了组件的布局和内容。
     */
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.debugLine("entry/src/main/ets/view/Home.ets(50:5)", "entry");
            Scroll.scrollBar(BarState.Off);
            Scroll.height(CommonConstants.FULL_PARENT);
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: CommonConstants.COMMON_SPACE });
            Column.debugLine("entry/src/main/ets/view/Home.ets(51:7)", "entry");
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 标题部分
            Column.create();
            Column.debugLine("entry/src/main/ets/view/Home.ets(53:9)", "entry");
            // 标题部分
            Column.width(CommonConstants.FULL_PARENT);
            // 标题部分
            Column.alignItems(HorizontalAlign.Start);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777243, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/view/Home.ets(54:11)", "entry");
            Text.fontWeight(FontWeight.Medium);
            Text.fontSize({ "id": 16777328, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.margin({ top: { "id": 16777320, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            Text.padding({ left: { "id": 16777321, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Text);
        Text.pop();
        // 标题部分
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 轮播图部分
            Swiper.create(this.swiperController);
            Swiper.debugLine("entry/src/main/ets/view/Home.ets(64:9)", "entry");
            // 轮播图部分
            Swiper.margin({ top: { "id": 16777298, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            // 轮播图部分
            Swiper.autoPlay(true);
        }, Swiper);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const img = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create(img);
                    Image.debugLine("entry/src/main/ets/view/Home.ets(66:13)", "entry");
                    Image.borderRadius({ "id": 16777297, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                }, Image);
            };
            this.forEachUpdateFunction(elmtId, mainViewModel.getSwiperImages(), forEachItemGenFunction, (img: Resource) => JSON.stringify(img.id), false, false);
        }, ForEach);
        ForEach.pop();
        // 轮播图部分
        Swiper.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 第一个网格：功能或分类展示
            Grid.create();
            Grid.debugLine("entry/src/main/ets/view/Home.ets(74:9)", "entry");
            // 第一个网格：功能或分类展示
            Grid.columnsTemplate('1fr 1fr 1fr 1fr');
            // 第一个网格：功能或分类展示
            Grid.rowsTemplate('1fr 1fr');
            // 第一个网格：功能或分类展示
            Grid.columnsGap({ "id": 16777284, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 第一个网格：功能或分类展示
            Grid.rowsGap({ "id": 16777288, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 第一个网格：功能或分类展示
            Grid.padding({ top: { "id": 16777287, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, bottom: { "id": 16777287, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            // 第一个网格：功能或分类展示
            Grid.height({ "id": 16777285, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 第一个网格：功能或分类展示
            Grid.backgroundColor(Color.White);
            // 第一个网格：功能或分类展示
            Grid.borderRadius({ "id": 16777283, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Grid);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                {
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        GridItem.create(() => { }, false);
                        GridItem.debugLine("entry/src/main/ets/view/Home.ets(76:13)", "entry");
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation2(itemCreation2, GridItem);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create();
                            Column.debugLine("entry/src/main/ets/view/Home.ets(77:15)", "entry");
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Image.create(item.img);
                            Image.debugLine("entry/src/main/ets/view/Home.ets(78:17)", "entry");
                            Image.width({ "id": 16777291, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                            Image.height({ "id": 16777291, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        }, Image);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(item.title);
                            Text.debugLine("entry/src/main/ets/view/Home.ets(81:17)", "entry");
                            Text.fontSize({ "id": 16777302, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                            Text.margin({ top: { "id": 16777290, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
                        }, Text);
                        Text.pop();
                        Column.pop();
                        GridItem.pop();
                    };
                    observedDeepRender();
                }
            };
            this.forEachUpdateFunction(elmtId, mainViewModel.getFirstGridData(), forEachItemGenFunction, (item: ItemData) => JSON.stringify(item), false, false);
        }, ForEach);
        ForEach.pop();
        // 第一个网格：功能或分类展示
        Grid.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 文本：列表标题
            Text.create({ "id": 16777234, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/view/Home.ets(98:9)", "entry");
            // 文本：列表标题
            Text.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 文本：列表标题
            Text.fontWeight(FontWeight.Medium);
            // 文本：列表标题
            Text.width(CommonConstants.FULL_PARENT);
            // 文本：列表标题
            Text.margin({ top: { "id": 16777299, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Text);
        // 文本：列表标题
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 第二个网格：列表或推荐内容展示
            Grid.create();
            Grid.debugLine("entry/src/main/ets/view/Home.ets(105:9)", "entry");
            // 第二个网格：列表或推荐内容展示
            Grid.width(CommonConstants.FULL_PARENT);
            // 第二个网格：列表或推荐内容展示
            Grid.height({ "id": 16777295, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 第二个网格：列表或推荐内容展示
            Grid.columnsTemplate('1fr 1fr');
            // 第二个网格：列表或推荐内容展示
            Grid.rowsTemplate('1fr 1fr');
            // 第二个网格：列表或推荐内容展示
            Grid.columnsGap({ "id": 16777284, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 第二个网格：列表或推荐内容展示
            Grid.rowsGap({ "id": 16777288, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 第二个网格：列表或推荐内容展示
            Grid.margin({ bottom: { "id": 16777336, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Grid);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const secondItem = _item;
                {
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        GridItem.create(() => { }, false);
                        GridItem.padding({ top: { "id": 16777294, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, left: { "id": 16777294, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
                        GridItem.borderRadius({ "id": 16777282, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        GridItem.align(Alignment.TopStart);
                        GridItem.backgroundImage(secondItem.img);
                        GridItem.backgroundImageSize(ImageSize.Cover);
                        GridItem.width(CommonConstants.FULL_PARENT);
                        GridItem.height(CommonConstants.FULL_PARENT);
                        GridItem.debugLine("entry/src/main/ets/view/Home.ets(107:13)", "entry");
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation2(itemCreation2, GridItem);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create();
                            Column.debugLine("entry/src/main/ets/view/Home.ets(108:15)", "entry");
                            Column.alignItems(HorizontalAlign.Start);
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(secondItem.title);
                            Text.debugLine("entry/src/main/ets/view/Home.ets(109:17)", "entry");
                            Text.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                            Text.fontWeight(FontWeight.Medium);
                        }, Text);
                        Text.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(secondItem.others);
                            Text.debugLine("entry/src/main/ets/view/Home.ets(112:17)", "entry");
                            Text.margin({ top: { "id": 16777293, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
                            Text.fontSize({ "id": 16777302, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                            Text.fontColor({ "id": 16777369, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        }, Text);
                        Text.pop();
                        Column.pop();
                        GridItem.pop();
                    };
                    observedDeepRender();
                }
            };
            this.forEachUpdateFunction(elmtId, mainViewModel.getSecondGridData(), forEachItemGenFunction, (secondItem: ItemData) => JSON.stringify(secondItem), false, false);
        }, ForEach);
        ForEach.pop();
        // 第二个网格：列表或推荐内容展示
        Grid.pop();
        Column.pop();
        Scroll.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
