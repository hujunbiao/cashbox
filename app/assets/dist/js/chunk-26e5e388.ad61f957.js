(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-26e5e388"],{"28a5":function(t,e,s){"use strict";var i=s("aae3"),a=s("cb7c"),n=s("ebd6"),r=s("0390"),o=s("9def"),l=s("5f1b"),c=s("520a"),u=s("79e5"),d=Math.min,g=[].push,h="split",p="length",v="lastIndex",f=4294967295,_=!u((function(){RegExp(f,"y")}));s("214f")("split",2,(function(t,e,s,u){var b;return b="c"=="abbc"[h](/(b)*/)[1]||4!="test"[h](/(?:)/,-1)[p]||2!="ab"[h](/(?:ab)*/)[p]||4!="."[h](/(.?)(.?)/)[p]||"."[h](/()()/)[p]>1||""[h](/.?/)[p]?function(t,e){var a=String(this);if(void 0===t&&0===e)return[];if(!i(t))return s.call(a,t,e);var n,r,o,l=[],u=(t.ignoreCase?"i":"")+(t.multiline?"m":"")+(t.unicode?"u":"")+(t.sticky?"y":""),d=0,h=void 0===e?f:e>>>0,_=new RegExp(t.source,u+"g");while(n=c.call(_,a)){if(r=_[v],r>d&&(l.push(a.slice(d,n.index)),n[p]>1&&n.index<a[p]&&g.apply(l,n.slice(1)),o=n[0][p],d=r,l[p]>=h))break;_[v]===n.index&&_[v]++}return d===a[p]?!o&&_.test("")||l.push(""):l.push(a.slice(d)),l[p]>h?l.slice(0,h):l}:"0"[h](void 0,0)[p]?function(t,e){return void 0===t&&0===e?[]:s.call(this,t,e)}:s,[function(s,i){var a=t(this),n=void 0==s?void 0:s[e];return void 0!==n?n.call(s,a,i):b.call(String(a),s,i)},function(t,e){var i=u(b,t,this,e,b!==s);if(i.done)return i.value;var c=a(t),g=String(this),h=n(c,RegExp),p=c.unicode,v=(c.ignoreCase?"i":"")+(c.multiline?"m":"")+(c.unicode?"u":"")+(_?"y":"g"),w=new h(_?c:"^(?:"+c.source+")",v),m=void 0===e?f:e>>>0;if(0===m)return[];if(0===g.length)return null===l(w,g)?[g]:[];var S=0,x=0,A=[];while(x<g.length){w.lastIndex=_?x:0;var y,C=l(w,_?g:g.slice(x));if(null===C||(y=d(o(w.lastIndex+(_?0:x)),g.length))===S)x=r(g,x,p);else{if(A.push(g.slice(S,x)),A.length===m)return A;for(var I=1;I<=C.length-1;I++)if(A.push(C[I]),A.length===m)return A;x=S=y}}return A.push(g.slice(S)),A}]}))},"2b66":function(t,e,s){},ab5e:function(t,e,s){"use strict";var i=s("2b66"),a=s.n(i);a.a},c049:function(t,e,s){"use strict";s.r(e);var i=function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("div",{staticClass:"original_sign_page"},[s("div",{staticClass:"sign_step1_group"},[s("span",{staticClass:"sign_step1_title"},[t._v(t._s(t.$t("original.signStepOne")))])]),s("div",{staticClass:"auth_title"},[s("van-cell-group",[s("van-cell",{attrs:{title:t.$t("original.operationMethod"),value:t.authTypeValue}})],1)],1),s("div",{staticClass:"auth_input_title_group"},[s("span",{staticClass:"auth_input_content"},[t._v(t._s(t.$t("original.modificationMsg")))])]),s("div",{staticClass:"input_message_group"},[s("van-cell-group",[s("van-cell",{attrs:{title:t.$t("original.name"),value:t.txName}},[t._v(t._s(t.txName))]),s("van-cell",{attrs:{title:t.$t("original.address"),value:t.txAddress}},[t._v(t._s(t.txAddress))])],1)],1),s("div",{staticClass:"origin_addr_group"},[s("span",{staticClass:"origin_addr_title"},[t._v(t._s(t.$t("original.addrMsg")))])]),s("div",{staticClass:"origin_message_group"},[s("van-cell-group",[s("van-cell",{attrs:{title:t.$t("original.signName"),value:t.nowApplyName}}),s("van-cell",{attrs:{title:t.$t("original.signAddr"),value:t.nowApplyAddress}})],1)],1),s("div",{staticClass:"sign_step2_group"},[s("span",{staticClass:"sign_step2_title"},[t._v(t._s(t.$t("original.signStepTwo")))])]),t.isShowQrLayout?s("div",{staticClass:"sign_qr"},[t.qrCodeText?s("scan-sign",{attrs:{code:t.qrCodeText,name:"sign"}}):t._e()],1):t._e(),s("div",{directives:[{name:"show",rawName:"v-show",value:!t.isShowQrLayout,expression:"!isShowQrLayout"}],staticClass:"qr_failure_group"},[s("span",{staticClass:"qr_failure_hint"},[t._v("获取二维码数据失败，请重新检查网络或数据参数")])]),s("div",{staticClass:"sign_step3_group"},[s("span",{staticClass:"sign_step3_title"},[t._v(t._s(t.$t("original.signStepThree")))])]),s("div",{staticClass:"get_signed"},[s("van-button",{attrs:{"van-button":"",plain:"",type:"info"},on:{click:t.scanGetSigned}},[t._v(t._s(t.$t("scanGetSign")))])],1),s("van-overlay",{attrs:{show:t.isLoadingAccount}},[s("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v("数据加载中...")])],1)],1)},a=[],n=(s("28a5"),s("96cf"),s("3b8d")),r=(s("6b54"),s("d225")),o=s("b0b4"),l=s("308d"),c=s("6bb5"),u=s("4e2b"),d=s("9ab4"),g=s("60a3"),h=s("ea47"),p=s("b650"),v=s("7744"),f=s("34e96"),_=s("d399"),b=(s("fb9c"),s("0147"),s("5f7d"),s("17d1"),s("c2d8"),s("87ab")),w=s("16ac"),m=s("8402"),S=s("45bc"),x=s("5aff"),A=s("1f21");g["d"].use(h["a"]).use(p["a"]).use(v["a"]).use(f["a"]).use(_["a"]);var y=function(t){function e(){var t;return Object(r["a"])(this,e),t=Object(l["a"])(this,Object(c["a"])(e).apply(this,arguments)),t.qrCodeText="",t.authTypeValue="",t.isLoadingAccount=!0,t.txAddress="",t.txName="",t.nowApplyName="",t.nowApplyAddress="",t.waitSignInfo="",t.isShowQrLayout=!1,t}return Object(u["a"])(e,t),Object(o["a"])(e,[{key:"created",value:function(){this.$store.state.title="信息签名",window.nativeQrScanToJsResult=this.nativeQrScanToJsResult,this.$store.state.authOriginalTxModel.authType==w["a"].DeleteAdmin?this.authTypeValue=this.$t("cancelOriginal").toString():this.authTypeValue=this.$t("authOriginal").toString()}},{key:"mounted",value:function(){var t=Object(n["a"])(regeneratorRuntime.mark((function t(){var e;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return e=this.$store.state.authOriginalTxModel,this.nowApplyName=e.nowAdminName,this.nowApplyAddress=e.nowAdminAddress,this.txAddress=e.txAddress,this.txName=e.txName,t.next=7,this.loadWaitSignInfo();case 7:this.isLoadingAccount=!1,this.qrCodeText="https://cashbox.scry.info/qr?ct=66&ot=ds&dt=0&dtt="+A["a"].QR_PARAM_ADMIN+"&v="+this.waitSignInfo+"&tl="+A["a"].QR_USEFUL_TIME()+"&",console.log("result qrCodeText info is===>"+this.qrCodeText);case 10:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"loadWaitSignInfo",value:function(){var t=Object(n["a"])(regeneratorRuntime.mark((function t(){return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(this.$store.state.authOriginalTxModel.authType!=w["a"].DeleteAdmin){t.next=6;break}return t.next=3,S["b"].getInstance().assembleDeleteAdminSingleMessage(this.nowApplyAddress,this.txAddress);case 3:this.waitSignInfo=t.sent,t.next=9;break;case 6:return t.next=8,S["b"].getInstance().assembleAddAdminSingleMessage(this.nowApplyAddress,this.txAddress,this.txName);case 8:this.waitSignInfo=t.sent;case 9:this.waitSignInfo&&""!==this.waitSignInfo?(console.log("!this.waitSignInfo is:"+!this.waitSignInfo),this.isShowQrLayout=!0):(console.log("!this.waitSignInfo is:"+!this.waitSignInfo),this.waitSignInfo="signIs error",x["a"].show("签名获取到的二维码信息错误，请重新尝试签名"));case 10:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"scanGetSigned",value:function(){m["a"].getInstance().callNativeQrScanToJs()}},{key:"nativeQrScanToJsResult",value:function(t){for(var e=t.split(";"),s={},i=0;i<e.length;i++){var a=i,n=e[a].indexOf("=");-1!==n&&(s[e[a].substring(0,n)]=e[a].substring(n+1))}var r="";if(s.dtt&&"01"==s.dtt&&s.v){r=s.v;var o=new w["c"];o.address=this.nowApplyAddress,o.signInfo=r,this.$store.commit("updateAdminAuthStatus",o),this.$router.push({name:"original_state_list"})}else x["a"].show("二维码信息有问题:"+t)}}]),e}(g["d"]);y=Object(d["a"])([Object(g["a"])({components:{ScanSign:b["a"]}})],y);var C=y,I=C,T=(s("ab5e"),s("2877")),$=Object(T["a"])(I,i,a,!1,null,"0d591dfe",null);e["default"]=$.exports},db80:function(t,e,s){},ea47:function(t,e,s){"use strict";var i=s("2638"),a=s.n(i),n=s("d282"),r=s("ba31"),o=s("b1d2"),l=s("7744"),c=s("34e96"),u=Object(n["a"])("panel"),d=u[0],g=u[1];function h(t,e,s,i){var n=function(){return[s.header?s.header():t(l["a"],{attrs:{icon:e.icon,label:e.desc,title:e.title,value:e.status,valueClass:g("header-value")},class:g("header")}),t("div",{class:g("content")},[s.default&&s.default()]),s.footer&&t("div",{class:[g("footer"),o["c"]]},[s.footer()])]};return t(c["a"],a()([{class:g(),scopedSlots:{default:n}},Object(r["b"])(i,!0)]))}h.props={icon:String,desc:String,title:String,status:String},e["a"]=d(h)},fb9c:function(t,e,s){s("a29f"),s("e60f"),s("db80")}}]);
//# sourceMappingURL=chunk-26e5e388.ad61f957.js.map