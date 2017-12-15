/**
 * Created by isling on 14/10/2017.
 */
function showReview() {
    const ShowReview = new Vue({
        el: '#show-review',
        data: {
            is_write_cmt: false,
            comment: {},
            reply: {},
            comments: [],
            like: { status: 0 },
        },
        mounted: function () {
            this.comment.user_id = $('textarea[name="comment"]').attr('data-current-user-id');
            this.reply.user_id = this.comment.user_id;
            this.comment.review_id = $('#show-review').attr('data-review-id');
            this.fetchLikeInfo();
            this.fetchData();
        },
        methods: {
            userLink: function (user_id) {
                return '/user/' + user_id;
            },
            formatTime: function (time) {
                let date = new Date(time);
                let day = date.getDate();
                let month = date.getMonth() + 1;
                let year = date.getFullYear();
                return `${year}年${month}月${day}日`;
            },
            fetchData: function () {
                let url = location.href + '.json';
                axios.get(url)
                    .then(res => {
                        this.comments = res.data;
                    })
                    .catch(err => {

                    });
            },
            fetchLikeInfo: function () {
                let url = '/likes/' + this.comment.user_id + '/' + this.comment.review_id + '.json';
                axios.get(url)
                    .then(res => {
                        this.like = res.data;
                    })
                    .catch(err => {

                    });
            },
            addReply: function (reply) {
                let idx = this.comments.findIndex(item => {
                    return reply.comment_id === item.id;
                });

                if (idx !== -1) {
                    this.comments[idx].replies.push(reply);
                    this.comments.splice();
                }
            },
            removeReply: function (comment_id, reply_id) {
                let idx = this.comments.findIndex(item => {
                    return comment_id === item.id;
                });

                if (idx !== -1) {
                    let replies = this.comments[idx].replies;
                    idx = replies.findIndex(item => {
                        return item.id === reply_id;
                    });

                    if (idx !== -1) {
                        replies.splice(idx, 1);
                        this.comments.splice();
                    }
                }
            },
            removeComment: function (comment_id) {
                let idx = this.comments.findIndex(item => {
                    return comment_id === item.id;
                });

                if (idx !== -1) {
                    this.comments.splice(idx, 1);
                }
            },
            postComment: function () {
                let url = '/comments.json';
                axios.post(url, {
                    comment: this.comment,
                })
                    .then(res => {
                        this.comments.push(res.data);
                        this.comment.content = '';
                        this.closeWriteCmtMode();
                    })
                    .catch(err => {
                    });
            },
            postReply: function (comment_id) {
                this.reply.comment_id = comment_id;
                let url = '/replies.json';
                axios.post(url, {
                    reply: this.reply,
                })
                    .then(res => {
                        this.addReply(res.data);
                        this.reply.content = '';
                    })
                    .catch(err => {
                    });
            },
            deleteComment: function (comment_id) {
                let url = '/comments/' + comment_id;
                axios.delete(url)
                    .then(res => {
                        if (!res.data.error) {
                            this.removeComment(comment_id);
                        }
                    })
                    .catch(err => {

                    });
            },
            deleteReply: function (reply_id) {
                let url = '/replies/' + reply_id;
                axios.delete(url)
                    .then(res => {
                        if (!res.data.error) {
                            comment_id = parseInt(res.data.comment_id);
                            this.removeReply(comment_id, reply_id);
                        }
                    })
                    .catch(err => {

                    });
            },
            changeLikeStatus: function () {
                if (this.like.status === 0) {
                    this.likef();
                } else {
                    this.unlike();
                }
            },
            likef: function () {
                let url = '/likes.json';
                axios.post(url, {
                    like: {
                        user_id: this.comment.user_id,
                        review_id: this.comment.review_id,
                    },
                })
                    .then(res => {
                        if (!res.data.error) {
                            this.like.status = 1;
                            this.like.id = res.data.id;
                            this.like.count++;
                        }
                    })
                    .catch(err => {

                    });
            },
            unlike: function () {
                let url = '/likes/' + this.like.id;
                axios.delete(url)
                    .then(res => {
                        if (!res.data.error) {
                            this.like.status = 0;
                            this.like.id = -1;
                            this.like.count--;
                        }
                    })
                    .catch(err => {

                    });
            },
            openWriteCmtMode: function () {
                this.is_write_cmt = true;
            },
            closeWriteCmtMode: function () {
                this.is_write_cmt = false;
            },
            openReply: function (comment_id) {
                this.closeReply(this.reply.comment_id);
                this.reply.comment_id = comment_id;
                $('#r' + comment_id).removeClass('u-hide');
            },
            closeReply: function (comment_id) {
                this.reply.content = '';
                if (comment_id) {
                    $('#r' + comment_id).addClass('u-hide');
                }
            },
        },
    });
}
