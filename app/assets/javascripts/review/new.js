/**
 * Created by isling on 12/10/2017.
 */
function newReview() {
    const WriteReview = new Vue({
        el: '#write-review',
        data: {
            hotelValue: '',
            hotelData: [{}],
            rate: 0,
            hotel: {},
        },
        computed: {
            avg_rate: function () {
                return this.hotel.rate_count ? Math.round(this.hotel.rate_sum * 100.0 / this.hotel.rate_count) / 100 : 0;
            },
        },
        mounted: function () {
            this.rate = parseInt($('.md-rating-bar').attr('data-rate')) ?
                parseInt($('.md-rating-bar').attr('data-rate')) : 0;
            this.fetchHotel();
            Review.init();
        },
        methods: {
            hotelFilter: function (list, query) {
                let arr = [];

                for (let i = 0; i < list.length; i++) {
                    if (list[i].name.indexOf(query) !== -1)
                        arr.push(list[i]);

                    if (arr.length > 5)
                        break;
                }

                return arr;
            },

            hotelCallback: function (item) {
                this.hotel = item;
            },

            fetchHotel: function () {
                axios.get('/hotels.json')
                    .then(res => {
                        console.log(res.data);
                        this.hotelData = res.data;
                    })
                    .catch(err => {

                    });
            },

            hotelInput: function () {
                this.hotel = {};
            }
        },
    });
}
