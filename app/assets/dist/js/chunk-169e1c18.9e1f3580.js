(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-169e1c18"],{"01fb":function(t,e,i){},"02de":function(t,e,i){"use strict";function n(t){var e=window.getComputedStyle(t),i="none"===e.display,n=null===t.offsetParent&&"fixed"!==e.position;return i||n}i.d(e,"a",(function(){return n}))},"0662":function(t,e,i){i("a29f"),i("adba")},"131c":function(t,e,i){},"2ae8":function(t,e,i){},"2bdd":function(t,e,i){"use strict";var n=i("d282"),a=i("02de"),r=i("5fbe"),s=i("a8c1"),o=i("543e"),c=Object(n["a"])("list"),l=c[0],h=c[1],d=c[2];e["a"]=l({mixins:[Object(r["a"])((function(t){this.scroller||(this.scroller=Object(s["d"])(this.$el)),t(this.scroller,"scroll",this.check)}))],model:{prop:"loading"},props:{error:Boolean,loading:Boolean,finished:Boolean,errorText:String,loadingText:String,finishedText:String,immediateCheck:{type:Boolean,default:!0},offset:{type:Number,default:300},direction:{type:String,default:"down"}},data:function(){return{innerLoading:this.loading}},updated:function(){this.innerLoading=this.loading},mounted:function(){this.immediateCheck&&this.check()},watch:{loading:"check",finished:"check"},methods:{check:function(){var t=this;this.$nextTick((function(){if(!(t.innerLoading||t.finished||t.error)){var e,i=t.$el,n=t.scroller,r=t.offset,s=t.direction;e=n.getBoundingClientRect?n.getBoundingClientRect():{top:0,bottom:n.innerHeight};var o=e.bottom-e.top;if(!o||Object(a["a"])(i))return!1;var c=!1,l=t.$refs.placeholder.getBoundingClientRect();c="up"===s?e.top-l.top<=r:l.bottom-e.bottom<=r,c&&(t.innerLoading=!0,t.$emit("input",!0),t.$emit("load"))}}))},clickErrorText:function(){this.$emit("update:error",!1),this.check()},genLoading:function(){var t=this.$createElement;if(this.innerLoading&&!this.finished)return t("div",{class:h("loading"),key:"loading"},[this.slots("loading")||t(o["a"],{attrs:{size:"16"}},[this.loadingText||d("loading")])])},genFinishedText:function(){var t=this.$createElement;if(this.finished){var e=this.slots("finished")||this.finishedText;if(e)return t("div",{class:h("finished-text")},[e])}},genErrorText:function(){var t=this.$createElement;if(this.error){var e=this.slots("error")||this.errorText;if(e)return t("div",{on:{click:this.clickErrorText},class:h("error-text")},[e])}}},render:function(){var t=arguments[0],e=t("div",{ref:"placeholder",class:h("placeholder")});return t("div",{class:h(),attrs:{role:"feed","aria-busy":this.innerLoading}},["down"===this.direction?this.slots():e,this.genLoading(),this.genFinishedText(),this.genErrorText(),"up"===this.direction?this.slots():e])}})},"681e":function(t,e,i){i("a29f"),i("01fb")},"71cf":function(t,e,i){i("a29f"),i("7565"),i("131c")},"76e2":function(t,e,i){"use strict";i.r(e);var n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"cert_list_page"},[i("div",{staticClass:"search_cert_list_group"},[i("van-search",{attrs:{placeholder:t.$t("inputCertNum"),"show-action":"",shape:"round"},on:{search:t.searchCert},model:{value:t.certSearchNum,callback:function(e){t.certSearchNum=e},expression:"certSearchNum"}},[i("div",{attrs:{slot:"action"},on:{click:t.searchCert},slot:"action"},[t._v(t._s(t.$t("search")))])])],1),i("div",{staticClass:"cert_title_group"},[i("span",{staticClass:"cert_gia_title"},[t._v(t._s(t.$t("giaNum")))]),i("span",{staticClass:"cert_carat_title"},[t._v(t._s(t.$t("carat")))]),i("span",{staticClass:"cert_clarity_title"},[t._v(t._s(t.$t("clarity")))])]),i("van-list",{staticClass:"cert_info_group",attrs:{finished:t.finished,"finished-text":t.$t("noMore")},on:{load:t.onLoad},model:{value:t.loading,callback:function(e){t.loading=e},expression:"loading"}},[t._l(t.showCertList,(function(e){return i("van-row",{staticClass:"cert_item_info",on:{click:function(i){return t.onClickRow(e.certGia.gia)}}},[i("van-divider",{staticClass:"divider_line"}),i("span",{staticClass:"cert_gia_info"},[t._v(t._s(e.certGia.gia))]),i("span",{staticClass:"cert_carat_info"},[t._v(t._s(e.certGia.carat))]),i("span",{staticClass:"cert_clarity_info"},[t._v(t._s(e.certGia.clarity))])],1)})),i("van-divider",{staticClass:"divider_line"})],2),i("van-overlay",{attrs:{show:t.isShowLoadingLayer}},[i("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v(t._s(t.loadHintInfo))])],1)],1)},a=[],r=(i("7db0"),i("d3b7"),i("25f0"),i("96cf"),i("c964")),s=i("276c"),o=i("e954"),c=i("e1a7"),l=i("f20d"),h=i("920b"),d=i("9ab4"),u=i("60a3"),f=i("ad06"),g=i("565f"),v=i("d1e1"),p=i("9ffb"),C=i("34e96"),b=i("7744"),w=i("2bdd"),L=i("9ed2"),_=i("543e"),m=i("6e47"),y=(i("1885"),i("5f7d"),i("17d1"),i("fdc4"),i("0662"),i("681e"),i("eeb2"),i("71cf"),i("e815"),i("b657"),i("5487")),k=i("7c42"),$=i("bb62");u["c"].use(f["a"]).use(g["a"]).use(v["a"]).use(p["a"]).use(C["a"]).use(b["a"]).use(w["a"]).use(L["a"]).use(_["a"]).use(m["a"]);var S=function(t){function e(){var t;return Object(s["a"])(this,e),t=Object(c["a"])(this,Object(l["a"])(e).apply(this,arguments)),t.cacheAllCertList=[],t.showCertList=[],t.loading=!1,t.finished=!0,t.certSearchNum="",t.isShowLoadingLayer=!1,t.loadHintInfo="",t}return Object(h["a"])(e,t),Object(o["a"])(e,[{key:"created",value:function(){this.$store.state.title=this.$t("certificateList").toString(),this.loadHintInfo=this.$t("dataSearching").toString()}},{key:"mounted",value:function(){this.finished=!1}},{key:"searchCert",value:function(){var t=this;if(window.console.log("begin search"+this.certSearchNum),this.cacheAllCertList.length<1)k["a"].fail(this.$t("certListIsEmpty").toString());else{for(var e,i=0;i<this.cacheAllCertList.length;i++)if(this.cacheAllCertList[i].certGia.gia&&this.cacheAllCertList[i].certGia.gia===this.certSearchNum){e=this.cacheAllCertList[i];break}if(null!==e&&void 0!==e)return this.showCertList=[],this.showCertList.push(e),void(this.$store.state.nowCertOwn=e);this.isShowLoadingLayer=!0,y["b"].getInstance().findCertByGia(this.$store.state.nativeChainAddress,this.certSearchNum).then((function(e){if(t.isShowLoadingLayer=!1,null!=e)return e?(t.showCertList=[],t.showCertList.push(e),void(t.$store.state.nowCertOwn=e)):(window.console.log(e),void k["a"].fail(t.$t("errorCertFormat").toString()));k["a"].fail(t.$t("giaNumNotExist").toString())})).catch((function(e){console.log("call findCertByGia error ===>"+e),t.isShowLoadingLayer=!1,k["a"].fail(t.$t("giaNumNotExist").toString())}))}}},{key:"onLoad",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(null!==$["a"].loadContractAddress()&&""!==$["a"].loadContractAddress()){t.next=5;break}return k["a"].show(this.$t("contractAddressIsNull").toString()),this.loading=!1,this.finished=!0,t.abrupt("return");case 5:return t.prev=5,this.isShowLoadingLayer=!0,t.next=9,y["b"].getInstance().loadCertList(this.$store.state.nativeChainAddress);case 9:e=t.sent,this.isShowLoadingLayer=!1,this.loading=!1,e.length>=1?(this.cacheAllCertList=e,this.showCertList=e,this.finished=!0):(k["a"].fail(this.$t("certListIsEmpty").toString()),this.finished=!0),t.next=22;break;case 15:t.prev=15,t.t0=t["catch"](5),this.loading=!1,this.finished=!0,this.isShowLoadingLayer=!1,console.log("loadCertList error数据加载失败===>"+t.t0.toString()),k["a"].fail(this.$t("unknownErrorPlsRecheck").toString());case 22:case"end":return t.stop()}}),t,this,[[5,15]])})));function e(){return t.apply(this,arguments)}return e}()},{key:"onClickRow",value:function(t){var e=this.showCertList.find((function(e){return e.certGia.gia===t}));e&&(console.log("certOwn.cert.id"+t),this.$store.state.nowCertOwn=e,this.$router.push("/frame/cert/detail"))}}]),e}(u["c"]);S=Object(d["a"])([u["a"]],S);var x=S,O=x,N=(i("daec"),i("2877")),A=Object(N["a"])(O,n,a,!1,null,"404aaba4",null);e["default"]=A.exports},"7db0":function(t,e,i){"use strict";var n=i("23e7"),a=i("b727").find,r=i("44d2"),s=i("ae40"),o="find",c=!0,l=s(o);o in[]&&Array(1)[o]((function(){c=!1})),n({target:"Array",proto:!0,forced:c||!l},{find:function(t){return a(this,t,arguments.length>1?arguments[1]:void 0)}}),r(o)},adba:function(t,e,i){},daec:function(t,e,i){"use strict";var n=i("2ae8"),a=i.n(n);a.a}}]);
//# sourceMappingURL=chunk-169e1c18.9e1f3580.js.map