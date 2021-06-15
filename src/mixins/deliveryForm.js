import { mapMutations, mapState } from 'vuex';
import HTTP from "../plugins/http";
const productArrived = {
    created () {
        this.getRegions();
    },
    data () {
        return {
            regions: [],
            cities: [],
            citiesIsLoading: false
        }
    },
    computed: {
        ...mapState('orderForm', ['city', 'street']),
        selectCityWrapper: {
            get () {
                return this.city
            },
            set (city) {
                this.setCity(city);
                this.getStreets(city.Ref)
            }
        },
        selectRegionWrapper: {
            get () {
                return this.region
            },
            set (region) {
                this.setRegion(region)
                this.getCities(region.Ref)
            }
        },
        cityWrapper: {
            get () {
                return this.city
            },
            set (value) {
                this.setCity(value)
            }
        },
        streetWrapper: {
            get () {
                return this.street;
            },
            set (value) {
                this.setStreet(value)
            }
        }
    },
    methods: {
        ...mapMutations("orderForm", ["setRegion", "setCity", "setStreet"]),
        async getRegions () {
            try {
                const { data } = await HTTP.get(
                    '/wa-plugins/shipping/siteprofnovaposhta/media/frontend/js/np_data/np_areas.js?_',
                );
                this.regions = data
            } catch (e) {
            }
        },
        async getCities (ref) {
            try {
                this.citiesIsLoading = true
                const { data } = await HTTP.get(`/wa-plugins/shipping/siteprofnovaposhta/media/frontend/js/np_data/cities_data/${ref}.js?_`)
                this.cities = data;
                this.citiesIsLoading = false;
            } catch (e) {
                this.citiesIsLoading = false;
            }
        },
    },
};
export default productArrived;