if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Setting_Params {
}
import CommonConstants from "@bundle:com.example.component/entry/ets/common/constants/CommonConstants";
import type ItemData from '../viewmodel/ItemData';
import mainViewModel from "@bundle:com.example.component/entry/ets/viewmodel/MainViewModel";
// 使用 @Component 装饰器，标记该结构体为一个 UI 组件。
export default class Setting extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Setting_Params) {
    }
    updateStateVars(params: Setting_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    // 定义并导出 Setting 组件，作为设置页面的主组件。
    settingCell(item: ItemData, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 定义一个构建器方法 settingCell，用于创建设置项的 UI，参数 item 为单个设置项的数据。
            Row.create();
            Row.debugLine("entry/src/main/ets/view/Setting.ets(39:5)", "entry");
            // 定义一个构建器方法 settingCell，用于创建设置项的 UI，参数 item 为单个设置项的数据。
            Row.justifyContent(FlexAlign.SpaceBetween);
            // 定义一个构建器方法 settingCell，用于创建设置项的 UI，参数 item 为单个设置项的数据。
            Row.width(CommonConstants.FULL_PARENT);
            // 定义一个构建器方法 settingCell，用于创建设置项的 UI，参数 item 为单个设置项的数据。
            Row.padding({
                left: { "id": 16777347, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
                // 设置左侧内边距为资源文件中定义的 setting_settingCell_left。
                right: { "id": 16777348, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }
                // 设置右侧内边距为资源文件中定义的 setting_settingCell_right。
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 使用 Row 组件创建一个水平行布局，组织设置项的内容。
            Row.create({ space: CommonConstants.COMMON_SPACE });
            Row.debugLine("entry/src/main/ets/view/Setting.ets(41:7)", "entry");
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 内部嵌套一个 Row 组件，设置子组件之间的间距为 COMMON_SPACE。
            Image.create(item.img);
            Image.debugLine("entry/src/main/ets/view/Setting.ets(43:9)", "entry");
            // 内部嵌套一个 Row 组件，设置子组件之间的间距为 COMMON_SPACE。
            Image.width({ "id": 16777349, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 内部嵌套一个 Row 组件，设置子组件之间的间距为 COMMON_SPACE。
            Image.height({ "id": 16777349, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 设置图标高度为资源文件中定义的 setting_size。
            Text.create(item.title);
            Text.debugLine("entry/src/main/ets/view/Setting.ets(49:9)", "entry");
            // 设置图标高度为资源文件中定义的 setting_size。
            Text.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Text);
        // 设置图标高度为资源文件中定义的 setting_size。
        Text.pop();
        // 使用 Row 组件创建一个水平行布局，组织设置项的内容。
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (item.others === undefined) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 判断 item.others 是否未定义（即没有额外信息）。
                        Image.create({ "id": 16777355, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        Image.debugLine("entry/src/main/ets/view/Setting.ets(57:9)", "entry");
                        // 判断 item.others 是否未定义（即没有额外信息）。
                        Image.width({ "id": 16777338, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        // 判断 item.others 是否未定义（即没有额外信息）。
                        Image.height({ "id": 16777337, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                    }, Image);
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 如果 item.others 有值（例如开关状态）。
                        Toggle.create({ type: ToggleType.Switch, isOn: false });
                        Toggle.debugLine("entry/src/main/ets/view/Setting.ets(65:9)", "entry");
                    }, Toggle);
                    // 如果 item.others 有值（例如开关状态）。
                    Toggle.pop();
                });
            }
        }, If);
        If.pop();
        // 定义一个构建器方法 settingCell，用于创建设置项的 UI，参数 item 为单个设置项的数据。
        Row.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 定义组件的构建方法，描述页面的整体 UI 结构。
            Scroll.create();
            Scroll.debugLine("entry/src/main/ets/view/Setting.ets(83:5)", "entry");
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 创建一个可滚动容器，包裹整个页面内容，支持上下滚动。
            Column.create({ space: CommonConstants.COMMON_SPACE });
            Column.debugLine("entry/src/main/ets/view/Setting.ets(85:7)", "entry");
            // 创建一个可滚动容器，包裹整个页面内容，支持上下滚动。
            Column.height(CommonConstants.FULL_PARENT);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 使用 Column 组件创建一个垂直列布局，子组件间距为 COMMON_SPACE。
            // 标题部分
            Column.create();
            Column.debugLine("entry/src/main/ets/view/Setting.ets(89:9)", "entry");
            // 使用 Column 组件创建一个垂直列布局，子组件间距为 COMMON_SPACE。
            // 标题部分
            Column.width(CommonConstants.FULL_PARENT);
            // 使用 Column 组件创建一个垂直列布局，子组件间距为 COMMON_SPACE。
            // 标题部分
            Column.alignItems(HorizontalAlign.Start);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 创建一个列布局，用于放置标题。
            Text.create({ "id": 16777244, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/view/Setting.ets(91:11)", "entry");
            // 创建一个列布局，用于放置标题。
            Text.fontWeight(FontWeight.Medium);
            // 创建一个列布局，用于放置标题。
            Text.fontSize({ "id": 16777328, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 创建一个列布局，用于放置标题。
            Text.margin({ top: { "id": 16777320, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            // 创建一个列布局，用于放置标题。
            Text.padding({ left: { "id": 16777321, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Text);
        // 创建一个列布局，用于放置标题。
        Text.pop();
        // 使用 Column 组件创建一个垂直列布局，子组件间距为 COMMON_SPACE。
        // 标题部分
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.create();
            Row.debugLine("entry/src/main/ets/view/Setting.ets(108:9)", "entry");
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.margin({ top: { "id": 16777332, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.alignItems(VerticalAlign.Center);
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.width(CommonConstants.FULL_PARENT);
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.height({ "id": 16777331, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.backgroundColor(Color.White);
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.padding({ left: { "id": 16777333, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
            // 设置子组件（标题）水平左对齐。
            // 账户信息部分
            Row.borderRadius({ "id": 16777329, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 创建一个行布局，用于展示账户信息。
            Image.create({ "id": 16777388, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Image.debugLine("entry/src/main/ets/view/Setting.ets(110:11)", "entry");
            // 创建一个行布局，用于展示账户信息。
            Image.width({ "id": 16777334, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 创建一个行布局，用于展示账户信息。
            Image.height({ "id": 16777334, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 设置头像高度为资源文件中定义的 setting_account_size。
            Column.create();
            Column.debugLine("entry/src/main/ets/view/Setting.ets(116:11)", "entry");
            // 设置头像高度为资源文件中定义的 setting_account_size。
            Column.alignItems(HorizontalAlign.Start);
            // 设置头像高度为资源文件中定义的 setting_account_size。
            Column.margin({ left: { "id": 16777332, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 创建一个列布局，用于展示用户名和邮箱。
            Text.create({ "id": 16777265, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/view/Setting.ets(118:13)", "entry");
            // 创建一个列布局，用于展示用户名和邮箱。
            Text.fontSize({ "id": 16777330, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
        }, Text);
        // 创建一个列布局，用于展示用户名和邮箱。
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 设置字体大小为资源文件中定义的 setting_account_fontSize。
            Text.create({ "id": 16777264, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/view/Setting.ets(122:13)", "entry");
            // 设置字体大小为资源文件中定义的 setting_account_fontSize。
            Text.fontSize({ "id": 16777302, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 设置字体大小为资源文件中定义的 setting_account_fontSize。
            Text.margin({ top: { "id": 16777345, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Text);
        // 设置字体大小为资源文件中定义的 setting_account_fontSize。
        Text.pop();
        // 设置头像高度为资源文件中定义的 setting_account_size。
        Column.pop();
        // 设置子组件（标题）水平左对齐。
        // 账户信息部分
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.create();
            List.debugLine("entry/src/main/ets/view/Setting.ets(150:9)", "entry");
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.scrollBar(BarState.Off);
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.backgroundColor(Color.White);
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.width(CommonConstants.FULL_PARENT);
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.height(CommonConstants.SET_LIST_WIDTH);
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.divider({
                strokeWidth: { "id": 16777344, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
                // 设置分隔线宽度为资源文件中定义的 setting_list_strokeWidth。
                color: Color.Grey,
                // 设置分隔线颜色为灰色。
                startMargin: { "id": 16777343, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
                // 设置分隔线左侧间距为资源文件中定义的 setting_list_startMargin。
                endMargin: { "id": 16777340, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }
                // 设置分隔线右侧间距为资源文件中定义的 setting_list_endMargin。
            });
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.borderRadius({ "id": 16777339, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
            // 设置选项列表部分
            List.padding({ top: { "id": 16777342, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, bottom: { "id": 16777342, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, List);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 创建一个 List 组件，用于展示设置选项列表。
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                {
                    const itemCreation = (elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        itemCreation2(elmtId, isInitialRender);
                        if (!isInitialRender) {
                            // 遍历 mainViewModel.getSettingListData() 返回的设置项数据。
                            ListItem.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    };
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        ListItem.create(deepRenderFunction, true);
                        // 遍历 mainViewModel.getSettingListData() 返回的设置项数据。
                        ListItem.height({ "id": 16777341, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
                        ListItem.debugLine("entry/src/main/ets/view/Setting.ets(154:13)", "entry");
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        // 创建一个列表项。
                        this.settingCell.bind(this)(item);
                        // 遍历 mainViewModel.getSettingListData() 返回的设置项数据。
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    // 遍历 mainViewModel.getSettingListData() 返回的设置项数据。
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, mainViewModel.getSettingListData(), forEachItemGenFunction, (item: ItemData) => JSON.stringify(item), false, false);
        }, ForEach);
        // 创建一个 List 组件，用于展示设置选项列表。
        ForEach.pop();
        // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。
        // 设置选项列表部分
        List.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 设置列表上下内边距为资源文件中定义的 setting_list_padding。
            // 空白占位部分
            Blank.create();
            Blank.debugLine("entry/src/main/ets/view/Setting.ets(189:9)", "entry");
        }, Blank);
        // 设置列表上下内边距为资源文件中定义的 setting_list_padding。
        // 空白占位部分
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.createWithLabel({ "id": 16777266, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { type: ButtonType.Capsule });
            Button.debugLine("entry/src/main/ets/view/Setting.ets(193:9)", "entry");
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.width(CommonConstants.BUTTON_WIDTH);
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.height({ "id": 16777303, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.fontColor({ "id": 16777381, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.fontWeight(FontWeight.Medium);
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.backgroundColor({ "id": 16777380, "type": 10001, params: [], "bundleName": "com.example.component", "moduleName": "entry" });
            // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
            // 操作按钮部分
            Button.margin({ bottom: { "id": 16777336, "type": 10002, params: [], "bundleName": "com.example.component", "moduleName": "entry" } });
        }, Button);
        // 添加一个空白组件，占据剩余空间，使按钮固定在底部。
        // 操作按钮部分
        Button.pop();
        // 创建一个可滚动容器，包裹整个页面内容，支持上下滚动。
        Column.pop();
        // 定义组件的构建方法，描述页面的整体 UI 结构。
        Scroll.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
