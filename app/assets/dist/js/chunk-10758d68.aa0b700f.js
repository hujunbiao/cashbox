(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-10758d68"],{"40d9":function(t,a,s){"use strict";s.r(a);var e=function(){var t=this,a=t.$createElement,s=t._self._c||a;return s("div",{staticClass:"original_sign_page"},[s("div",{staticClass:"sign_step1_group"},[s("span",{staticClass:"sign_step1_title"},[t._v(t._s(t.$t("original.signStepOne")))])]),s("div",{staticClass:"auth_type_group"},[s("span",{staticClass:"auth_type_key"},[t._v(t._s(t.$t("original.operationMethod")))]),s("span",{staticClass:"auth_type_value"},[t._v(t._s(t.authTypeValue))])]),s("div",{staticClass:"auth_input_title_group"},[s("span",{staticClass:"auth_input_content"},[t._v(t._s(t.$t("original.modificationMsg")))])]),s("div",{staticClass:"input_message_group"},[s("div",{staticClass:"target_admin_name_group"},[s("span",{staticClass:"target_admin_name_key"},[t._v(t._s(t.$t("original.name")))]),s("span",{staticClass:"target_admin_name_value"},[t._v(t._s(t.targetTxName))])]),s("div",{staticClass:"target_admin_address_group"},[s("span",{staticClass:"target_admin_address_key"},[t._v(t._s(t.$t("original.address")))]),s("span",{staticClass:"target_admin_address_value"},[t._v(t._s(t.targetTxAddress))])])]),s("div",{staticClass:"auth_admin_title_group"},[s("span",{staticClass:"auth_admin_title"},[t._v(t._s(t.$t("original.addrMsg")))])]),s("div",{staticClass:"auth_admin_group"},[s("span",{staticClass:"auth_admin_key"},[t._v(t._s(t.$t("original.nowAuthAdminAddress")))]),s("span",{staticClass:"auth_admin_value"},[t._v(t._s(t.nowAdminAddress))])]),s("div",{staticClass:"sign_step2_group"},[s("span",{staticClass:"sign_step3_title"},[t._v(t._s(t.$t("original.signStepTwo")))])]),s("div",{staticClass:"sign_btn_group"},[s("van-button",{attrs:{"van-button":"",plain:"",type:"info"},on:{click:t.verifyPwdAndBroadcast}},[t._v("密码签名，验证上链")])],1),s("van-overlay",{attrs:{show:t.isLoadingAccount}},[s("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v("数据加载中...")])],1)],1)},i=[],n=(s("99af"),s("4160"),s("d3b7"),s("ac1f"),s("25f0"),s("5319"),s("159b"),s("bf19"),s("96cf"),s("c964")),o=s("276c"),r=s("e954"),c=s("e1a7"),l=s("f20d"),d=s("920b"),u=s("9ab4"),g=s("60a3"),h=s("2638"),_=s.n(h),p=s("d282"),v=s("ba31"),f=s("b1d2"),m=s("7744"),w=s("34e96"),b=Object(p["a"])("panel"),S=b[0],y=b[1];function A(t,a,s,e){var i=function(){return[s.header?s.header():t(m["a"],{attrs:{icon:a.icon,label:a.desc,title:a.title,value:a.status,valueClass:y("header-value")},class:y("header")}),t("div",{class:y("content")},[s.default&&s.default()]),s.footer&&t("div",{class:[y("footer"),f["c"]]},[s.footer()])]};return t(w["a"],_()([{class:y(),scopedSlots:{default:i}},Object(v["b"])(e,!0)]))}A.props={icon:String,desc:String,title:String,status:String};var T=S(A),C=s("b650"),O=s("d399"),x=(s("fb9c"),s("0147"),s("5f7d"),s("17d1"),s("c2d8"),s("106a")),$=s("36d1"),I=s("8402"),k=s("5487"),M=s("7c42");g["c"].use(T).use(C["a"]).use(m["a"]).use(w["a"]).use(O["a"]);var j=function(t){function a(){var t;return Object(o["a"])(this,a),t=Object(c["a"])(this,Object(l["a"])(a).apply(this,arguments)),t.authTypeValue="",t.isLoadingAccount=!0,t.targetTxAddress="",t.targetTxName="",t.nowAdminAddress="",t.waitSignInfo="",t.isShowLoading=!1,t}return Object(d["a"])(a,t),Object(r["a"])(a,[{key:"created",value:function(){this.$store.state.title="信息签名",window.nativeSignMsgToJsResult=this.nativeSignMsgToJsResult,this.$store.state.authOriginalTxModel.authType==$["a"].DeleteAdmin?this.authTypeValue=this.$t("cancelOriginal").toString():this.authTypeValue=this.$t("authOriginal").toString()}},{key:"mounted",value:function(){var t=Object(n["a"])(regeneratorRuntime.mark((function t(){var a;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return a=this.$store.state.authOriginalTxModel,this.nowAdminAddress=a.nowAdminAddress,console.log("confirm page this.nowAdminAddress===>"+a.nowAdminAddress+"||"+this.nowAdminAddress),this.targetTxAddress=a.targetTxAddress,this.targetTxName=a.targetTxName,t.next=7,this.loadWaitSignInfo();case 7:this.isLoadingAccount=!1;case 8:case"end":return t.stop()}}),t,this)})));function a(){return t.apply(this,arguments)}return a}()},{key:"loadWaitSignInfo",value:function(){var t=Object(n["a"])(regeneratorRuntime.mark((function t(){return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return console.log("this.$store.state.authOriginalTxModel.authType is===>"+this.$store.state.authOriginalTxModel.authType),this.isShowLoading=!0,t.next=4,k["b"].getInstance().assembleAdminSingleMessage(this.$store.state.authOriginalTxModel.authType,this.$store.state.nativeChainAddress,this.targetTxAddress,this.targetTxName);case 4:this.waitSignInfo=t.sent,console.log("this.waitSignInfo is:===》"+this.waitSignInfo),this.isShowLoading=!1,this.waitSignInfo&&""!==this.waitSignInfo||(this.waitSignInfo="",M["a"].show("拼装数据失败，请重新尝试")),console.log("this.waitSignInfo is OK===>"+this.waitSignInfo);case 9:case"end":return t.stop()}}),t,this)})));function a(){return t.apply(this,arguments)}return a}()},{key:"verifyPwdAndBroadcast",value:function(){I["a"].getInstance().callNativeSignMsgToJs(this.waitSignInfo)}},{key:"nativeSignMsgToJsResult",value:function(t){var a=this;console.log("own_input nativeSignMsgToJsResult===>"+t),k["b"].getInstance().sendToChain(t,(function(t){if(a.isShowLoading=!1,t.isFinalized){console.log("use balance is finished!===>");var s=t.asFinalized;k["b"].getInstance().loadApiPromise().then((function(t){t.query.system.events.at(s).then((function(t){var a=!1;t.forEach((function(t){var s=t.phase,e=t.event,i=e.data,n=e.method,o=e.section;"contracts"==o&&"ContractExecution"==n&&(console.log("contracts===>"+i.toJSON()),M["a"].show("信息上链已完成，可在浏览器查询交易状态",8e3),a=!0),console.log("forEach  =>"+s.toString()+"||section=>"+": ".concat(o,".").concat(n)+i.toString())})),a||M["a"].fail("信息上链失败，链上调用出现问题！~",8e3)}))}))}if(t.isBroadcast&&(console.log("status.isBroadcast===>"),M["a"].show("信息上链已完成，可在浏览器查询交易状态")),t.isDropped)return console.log("status.isDropped===>"),void M["a"].fail("信息上链失败，操作已被丢弃");if(t.isInvalid)return console.log("status.isInvalid!===>"),void M["a"].fail("信息上链失败，无效操作");var e=a;setTimeout((function(){e.$router.push({name:"original_process"})}),1e3)})).catch((function(t){a.isShowLoading=!1,console.log("Error reason===>"+t),a.$router.replace({name:"original_entry"}),M["a"].fail("数据上链中，出现错误！！！请重新尝试操作")}))}}]),a}(g["c"]);j=Object(u["a"])([Object(g["a"])({components:{ScanSign:x["a"]}})],j);var J=j,L=J,R=(s("9d14"),s("2877")),N=Object(R["a"])(L,e,i,!1,null,"2d61c255",null);a["default"]=N.exports},"9d14":function(t,a,s){"use strict";var e=s("bc24"),i=s.n(e);i.a},bc24:function(t,a,s){},db80:function(t,a,s){},fb9c:function(t,a,s){s("a29f"),s("0607"),s("949e"),s("247c"),s("836f"),s("db80")}}]);
//# sourceMappingURL=chunk-10758d68.aa0b700f.js.map