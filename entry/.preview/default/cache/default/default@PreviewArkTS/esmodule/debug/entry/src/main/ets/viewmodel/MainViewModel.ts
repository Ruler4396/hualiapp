import ItemData from "@bundle:com.example.component/entry/ets/viewmodel/ItemData";
/**
 * MainViewModel 类：绑定数据到组件并提供接口。
 * 该类作为 ViewModel，提供方法来获取 UI 组件所需的数据。
 */
export class MainViewModel {
    /**
     * 获取轮播图图片数据。
     *
     * @return {Array<Resource>} 轮播图图片资源的数组。
     */
    getSwiperImages(): Array<Resource> {
        // 定义并初始化轮播图图片资源数组
        let swiperImages: Resource[] = [
            { "id": 16777219, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
            { "id": 16777392, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
            { "id": 16777365, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" },
            { "id": 16777218, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }
        ];
        return swiperImages; // 返回轮播图图片资源数组
    }
    /**
     * 获取第一个网格的数据。
     *
     * @return {Array<ItemData>} 第一个网格的数据项数组。
     */
    getFirstGridData(): Array<ItemData> {
        // 定义并初始化第一个网格的数据项数组
        let firstGridData: ItemData[] = [
            new ItemData({ "id": 16777256, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777396, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777233, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777361, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777251, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777357, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777274, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777387, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777255, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777353, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777232, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777359, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777229, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777397, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777262, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777278, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }) // “回收站”项
        ];
        return firstGridData; // 返回第一个网格的数据项数组
    }
    /**
     * 获取第二个网格的数据。
     *
     * @return {Array<ItemData>} 第二个网格的数据项数组。
     */
    getSecondGridData(): Array<ItemData> {
        // 定义并初始化第二个网格的数据项数组
        let secondGridData: ItemData[] = [
            new ItemData({ "id": 16777249, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777362, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777248, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777242, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777385, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777247, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777240, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777395, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777245, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777241, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777391, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777246, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }) // “发现”项
        ];
        return secondGridData; // 返回第二个网格的数据项数组
    }
    /**
     * 获取设置列表的数据。
     *
     * @return {Array<ItemData>} 设置列表的数据项数组。
     */
    getSettingListData(): Array<ItemData> {
        // 定义并初始化设置列表的数据项数组
        let settingListData: ItemData[] = [
            new ItemData({ "id": 16777270, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777352, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777273, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777268, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777220, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777269, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777354, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777267, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777394, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777272, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777221, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }),
            new ItemData({ "id": 16777271, "type": 10003, params: [], "bundleName": "com.example.component", "moduleName": "entry" }, { "id": 16777364, "type": 20000, params: [], "bundleName": "com.example.component", "moduleName": "entry" }) // “隐私”项
        ];
        return settingListData; // 返回设置列表的数据项数组
    }
}
/**
 * 导出 MainViewModel 的单例实例。
 * 这样在应用程序中可以直接使用这个实例来访问数据方法。
 */
export default new MainViewModel();
