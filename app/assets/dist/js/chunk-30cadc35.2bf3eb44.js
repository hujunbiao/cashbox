(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-30cadc35"],{"01fb":function(t,e,n){},"0662":function(t,e,n){n("a29f"),n("adba")},"106a":function(t,e,n){"use strict";var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("van-row",{attrs:{type:"flex",justify:"center"}},[n("van-col",[n("v-qrcode",{staticClass:"qr_show",attrs:{code:t.code}})],1)],1),n("van-row",{attrs:{type:"flex",justify:"center"}},[n("van-col",{staticClass:"scan_tip"},[t._v(" "+t._s(t.$t("signByScan"))+" ")])],1)],1)},a=[],s=n("276c"),r=n("e1a7"),c=n("f20d"),o=n("920b"),l=n("9ab4"),u=n("60a3"),d=n("4290"),h=(n("0662"),n("681e"),function(t){function e(){return Object(s["a"])(this,e),Object(r["a"])(this,Object(c["a"])(e).apply(this,arguments))}return Object(o["a"])(e,t),e}(u["c"]));Object(l["a"])([Object(u["b"])({default:""})],h.prototype,"code",void 0),h=Object(l["a"])([Object(u["a"])({components:{VQrcode:d["a"]}})],h);var f=h,b=f,v=(n("7452"),n("2877")),p=Object(v["a"])(b,i,a,!1,null,"07e0cd79",null);e["a"]=p.exports},2477:function(t,e,n){n("a29f")},"46d4":function(t,e,n){"use strict";n.r(e);var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"wait_to_sign_page"},[n("div",{staticClass:"cert_message_group"},[n("span",{staticClass:"cert_message_title"},[t._v(t._s(t.$t("chainCertInfo")))])]),n("div",{staticClass:"cert_show_group"},[n("cert-show",{staticClass:"cert_show_card"})],1),n("div",{staticClass:"sign_method_group"},[n("span",{staticClass:"sign_method_title"},[t._v(t._s(t.$t("messageSigned")))])]),n("van-overlay",{attrs:{show:t.isLoadingAccount}},[n("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v(t._s(t.$t("dataLoading")))])],1),n("div",{staticClass:"choose_method_group"},[n("van-button",{staticClass:"self_auth_method",attrs:{type:"default"},on:{click:t.onClickToSign}},[t._v(" "+t._s(t.$t("pwdSignAndUpToChain"))+" ")])],1)],1)},a=[],s=(n("d3b7"),n("25f0"),n("276c")),r=n("e954"),c=n("e1a7"),o=n("f20d"),l=n("920b"),u=n("9ab4"),d=n("60a3"),h=n("b650"),f=n("9f14"),b=n("e27c"),v=n("6e47"),p=n("c7fe"),g=n("106a"),m=n("8402"),_=(n("0147"),n("0662"),n("681e"),n("7597"),n("2477"),n("e815"),n("6848")),C=n("7c42"),O=n("5487");d["c"].use(h["a"]).use(f["a"]).use(b["a"]).use(v["a"]);var y=function(t){function e(){var t;return Object(s["a"])(this,e),t=Object(c["a"])(this,Object(o["a"])(e).apply(this,arguments)),t.isLoadingAccount=!1,t}return Object(l["a"])(e,t),Object(r["a"])(e,[{key:"created",value:function(){window.nativeSignMsgToJsResult=this.nativeSignMsgToJsResult,this.certOwn=this.$store.state.nowCertOwn,this.$store.state.title=this.$t("messageSigned").toString()}},{key:"onClickToSign",value:function(){var t=this;this.isLoadingAccount=!0,O["b"].getInstance().assembleAddCertInfo(this.certOwn.certGia.gia,this.certOwn,this.$store.state.nativeChainAddress).then((function(e){if(console.log("res===>"+e),t.isLoadingAccount=!1,!t.$store.state.nativeChainAddress||""===t.$store.state.nativeChainAddress)return C["a"].fail(t.$t("businessAddressIsNull").toString()),void console.log("assembleAddCertInfo business address is null,error===>"+t.$store.state.nativeChainAddress);t.$store.commit("updateCertBusinessAddress",t.$store.state.nativeChainAddress),m["a"].getInstance().callNativeSignMsgToJs(e)})).catch((function(e){t.isLoadingAccount=!1,C["a"].fail(t.$t("assembleDataError").toString()),console.log("assembleAddCertInfo===>"+e.toString())}))}},{key:"nativeSignMsgToJsResult",value:function(t){console.log("success finish sign step!"),this.$store.commit("updateNowCertSignedInfo",t),this.$store.commit("updateNowCertSignState",_["c"].Success);var e=this;setTimeout((function(){e.$router.push("/frame/cert/confirm")}),1e3)}}]),e}(d["c"]);y=Object(u["a"])([Object(d["a"])({components:{CertShow:p["a"],ScanSign:g["a"]}})],y);var w=y,S=w,j=(n("51a0"),n("2877")),k=Object(j["a"])(S,i,a,!1,null,"f538e120",null);e["default"]=k.exports},"51a0":function(t,e,n){"use strict";var i=n("c254"),a=n.n(i);a.a},"681e":function(t,e,n){n("a29f"),n("01fb")},7452:function(t,e,n){"use strict";var i=n("a732"),a=n.n(i);a.a},7597:function(t,e,n){n("a29f"),n("0607"),n("949e"),n("857f")},"857f":function(t,e,n){},9884:function(t,e,n){"use strict";n.d(e,"a",(function(){return s})),n.d(e,"b",(function(){return r}));var i=n("2b0e");function a(t){var e=[];function n(t){t.forEach((function(t){e.push(t),t.children&&n(t.children)}))}return n(t),e}function s(t,e){var n,s;void 0===e&&(e={});var r=e.indexKey||"index";return i["a"].extend({inject:(n={},n[t]={default:null},n),computed:(s={parent:function(){return this.disableBindRelation?null:this[t]}},s[r]=function(){return this.bindRelation(),this.parent.children.indexOf(this)},s),mounted:function(){this.bindRelation()},beforeDestroy:function(){var t=this;this.parent&&(this.parent.children=this.parent.children.filter((function(e){return e!==t})))},methods:{bindRelation:function(){if(this.parent&&-1===this.parent.children.indexOf(this)){var t=[].concat(this.parent.children,[this]),e=a(this.parent.slots());t.sort((function(t,n){return e.indexOf(t.$vnode)-e.indexOf(n.$vnode)})),this.parent.children=t}}}})}function r(t){return{provide:function(){var e;return e={},e[t]=this,e},data:function(){return{children:[]}}}}},"9f14":function(t,e,n){"use strict";var i=n("d282"),a=n("ad06"),s=n("9884"),r=n("ea8e"),c=function(t){var e=t.parent,n=t.bem,i=t.role;return{mixins:[Object(s["a"])(e)],props:{name:null,value:null,disabled:Boolean,iconSize:[Number,String],checkedColor:String,labelPosition:String,labelDisabled:Boolean,shape:{type:String,default:"round"},bindGroup:{type:Boolean,default:!0}},computed:{disableBindRelation:function(){return!this.bindGroup},isDisabled:function(){return this.parent&&this.parent.disabled||this.disabled},iconStyle:function(){var t=this.checkedColor||this.parent&&this.parent.checkedColor;if(t&&this.checked&&!this.isDisabled)return{borderColor:t,backgroundColor:t}},tabindex:function(){return this.isDisabled||"radio"===i&&!this.checked?-1:0}},methods:{onClick:function(t){var e=t.target,n=this.$refs.icon,i=n===e||n.contains(e);this.isDisabled||!i&&this.labelDisabled||this.toggle(),this.$emit("click",t)},genIcon:function(){var t=this.$createElement,e=this.checked,i=this.iconSize||this.parent&&this.parent.iconSize;return t("div",{ref:"icon",class:n("icon",[this.shape,{disabled:this.isDisabled,checked:e}]),style:{fontSize:Object(r["a"])(i)}},[this.slots("icon",{checked:e})||t(a["a"],{attrs:{name:"success"},style:this.iconStyle})])},genLabel:function(){var t=this.$createElement,e=this.slots();if(e)return t("span",{class:n("label",[this.labelPosition,{disabled:this.isDisabled}])},[e])}},render:function(){var t=arguments[0],e=[this.genIcon()];return"left"===this.labelPosition?e.unshift(this.genLabel()):e.push(this.genLabel()),t("div",{attrs:{role:i,tabindex:this.tabindex,"aria-checked":String(this.checked)},class:n({disabled:this.isDisabled,"label-disabled":this.labelDisabled}),on:{click:this.onClick}},[e])}}},o=Object(i["a"])("radio"),l=o[0],u=o[1];e["a"]=l({mixins:[c({bem:u,role:"radio",parent:"vanRadio"})],computed:{currentValue:{get:function(){return this.parent?this.parent.value:this.value},set:function(t){(this.parent||this).$emit("input",t)}},checked:function(){return this.currentValue===this.name}},methods:{toggle:function(){this.currentValue=this.name}}})},a630:function(t,e,n){var i=n("23e7"),a=n("4df4"),s=n("1c7e"),r=!s((function(t){Array.from(t)}));i({target:"Array",stat:!0,forced:r},{from:a})},a732:function(t,e,n){},a866:function(t,e,n){},adba:function(t,e,n){},c254:function(t,e,n){},c5b7:function(t,e,n){"use strict";var i=n("a866"),a=n.n(i);a.a},c7fe:function(t,e,n){"use strict";var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"cert_detail_cls"},t._l(t.certMap,(function(e){return n("div",{staticClass:"item_cert_row"},[n("div",{staticClass:"item_group"},[n("span",{staticClass:"item_cert_key"},[t._v(t._s(e.key))]),n("span",{staticClass:"item_cert_value"},[t._v(t._s(e.value))])]),n("van-divider",{staticClass:"divider_line"})],1)})),0)},a=[];n("a4d3"),n("e01a"),n("d28b"),n("d81d"),n("d3b7"),n("3ca3"),n("ddb0");function s(t){if(Array.isArray(t)){for(var e=0,n=new Array(t.length);e<t.length;e++)n[e]=t[e];return n}}n("a630"),n("e260"),n("25f0");function r(t){if(Symbol.iterator in Object(t)||"[object Arguments]"===Object.prototype.toString.call(t))return Array.from(t)}function c(){throw new TypeError("Invalid attempt to spread non-iterable instance")}function o(t){return s(t)||r(t)||c()}var l=n("276c"),u=n("e954"),d=n("e1a7"),h=n("f20d"),f=n("920b"),b=n("9ab4"),v=n("60a3"),p=n("9ed2");n("eeb2");v["c"].use(p["a"]);var g=function(t){function e(){return Object(l["a"])(this,e),Object(d["a"])(this,Object(h["a"])(e).apply(this,arguments))}return Object(f["a"])(e,t),Object(u["a"])(e,[{key:"certMap",get:function(){this.certOwn||(this.certOwn=this.$store.state.nowCertOwn);var t=[];if(this.certOwn&&this.certOwn.certGia&&(t.push.apply(t,o(this.certOwn.certGia.toCert().map)),this.certOwn.certGia.toCert().i18n)){var e=!0,n=!1,i=void 0;try{for(var a,s=this.certOwn.certGia.toCert().map.keys()[Symbol.iterator]();!(e=(a=s.next()).done);e=!0){var r=a.value,c=this.certOwn.certGia.toCert().map[r],l=this.$t(c.key);l&&(c.key=l,t[r]=c)}}catch(u){n=!0,i=u}finally{try{e||null==s.return||s.return()}finally{if(n)throw i}}}return t}}]),e}(v["c"]);g=Object(b["a"])([Object(v["a"])({name:"CertCard"})],g);var m=g,_=m,C=(n("c5b7"),n("2877")),O=Object(C["a"])(_,i,a,!1,null,null,null);e["a"]=O.exports},e27c:function(t,e,n){"use strict";var i=n("d282"),a=n("9884"),s=Object(i["a"])("radio-group"),r=s[0],c=s[1];e["a"]=r({mixins:[Object(a["b"])("vanRadio")],props:{value:null,disabled:Boolean,checkedColor:String,iconSize:[Number,String]},watch:{value:function(t){this.$emit("change",t)}},render:function(){var t=arguments[0];return t("div",{class:c(),attrs:{role:"radiogroup"}},[this.slots()])}})}}]);
//# sourceMappingURL=chunk-30cadc35.2bf3eb44.js.map