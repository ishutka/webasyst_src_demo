const topMenu = {
  namespaced: true,
  state: {
    items: [],
    currentFirstMenu: 0,
    currentSecondMenu: 0,
    currentThirdMenu: 0,
    isMobile: false,
    isTouchScreen: false,
    menuHeight: 0,
    menuIsSwitched: false,
  },
  getters: {
    getItemsByDepth: state => depth =>
      state.items.filter(item => item.depth === depth),
    getFirstLevelItems: (state, getters) => getters.getItemsByDepth(0),
    getSecondLevelItems: (state, getters) =>
      getters
        .getItemsByDepth(1)
        .filter(row => row.parent_id === state.currentFirstMenu),

    getThirdLevelItems: (state, getters) => id =>
      getters.getItemsByDepth(2).filter(row => row.parent_id === id),
    getCurrentFirstMenu: (state, getters) =>
      getters.getFirstLevelItems.find(
        item => item.id === state.currentFirstMenu,
      ),
  },
  mutations: {
    pushMenuButton(state) {
      state.menuIsSwitched = !state.menuIsSwitched;
      state.currentFirstMenu = 0;
    },
    setIsMobile(state, bool) {
      state.isMobile = bool;
    },
    setIsTouchScreen(state, bool) {
      state.isTouchScreen = bool;
    },
    setCurrentFirstMenu(state, id) {
      state.currentFirstMenu = id;
    },
    setCurrentSecondMenu(state, id) {
      state.currentSecondMenu = id;
    },
    setCurrentThirdMenu(state, id) {
      state.currentThirdMenu = id;
    },
  },
  actions: {
    getMenu({ state }) {
      jQuery.ajax({
        url: '/siteprofmenu/getTopMenu/',
        dataType: 'json',
        success: ({ data }) => {
          state.items = data.items;
        },
      });
    },
    setWidthWatcher() {
      const setAdaptiveParams = () => {
        if (window.innerWidth < 992)
          this.commit('topMenu/setIsTouchScreen', true);
        else this.commit('topMenu/setIsTouchScreen', false);
        if (window.innerWidth < 768) this.commit('topMenu/setIsMobile', true);
        else this.commit('topMenu/setIsMobile', false);
      };
      setAdaptiveParams();
      window.addEventListener('resize', setAdaptiveParams);
    },
  },
};

export default topMenu;
