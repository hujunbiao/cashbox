(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-1406805e"],{"0147":function(t,e,i){i("a29f"),i("0607"),i("949e"),i("7565"),i("dfda")},"01fb":function(t,e,i){},"0662":function(t,e,i){i("a29f"),i("adba")},"0958":function(t,e,i){},"0e2f":function(t,e,i){},"1fde":function(t,e,i){"use strict";var n=i("0e2f"),s=i.n(n);s.a},2477:function(t,e,i){i("a29f")},"339f":function(t,e,i){i("a29f"),i("875a")},"681e":function(t,e,i){i("a29f"),i("01fb")},7597:function(t,e,i){i("a29f"),i("0607"),i("949e"),i("857f")},"857f":function(t,e,i){},"875a":function(t,e,i){},9884:function(t,e,i){"use strict";i.d(e,"a",(function(){return a})),i.d(e,"b",(function(){return o}));var n=i("2b0e");function s(t){var e=[];function i(t){t.forEach((function(t){e.push(t),t.children&&i(t.children)}))}return i(t),e}function a(t,e){var i,a;void 0===e&&(e={});var o=e.indexKey||"index";return n["a"].extend({inject:(i={},i[t]={default:null},i),computed:(a={parent:function(){return this.disableBindRelation?null:this[t]}},a[o]=function(){return this.bindRelation(),this.parent.children.indexOf(this)},a),mounted:function(){this.bindRelation()},beforeDestroy:function(){var t=this;this.parent&&(this.parent.children=this.parent.children.filter((function(e){return e!==t})))},methods:{bindRelation:function(){if(this.parent&&-1===this.parent.children.indexOf(this)){var t=[].concat(this.parent.children,[this]),e=s(this.parent.slots());t.sort((function(t,i){return e.indexOf(t.$vnode)-e.indexOf(i.$vnode)})),this.parent.children=t}}}})}function o(t){return{provide:function(){var e;return e={},e[t]=this,e},data:function(){return{children:[]}}}}},"9f14":function(t,e,i){"use strict";var n=i("d282"),s=i("ad06"),a=i("9884"),o=i("ea8e"),r=function(t){var e=t.parent,i=t.bem,n=t.role;return{mixins:[Object(a["a"])(e)],props:{name:null,value:null,disabled:Boolean,iconSize:[Number,String],checkedColor:String,labelPosition:String,labelDisabled:Boolean,shape:{type:String,default:"round"},bindGroup:{type:Boolean,default:!0}},computed:{disableBindRelation:function(){return!this.bindGroup},isDisabled:function(){return this.parent&&this.parent.disabled||this.disabled},iconStyle:function(){var t=this.checkedColor||this.parent&&this.parent.checkedColor;if(t&&this.checked&&!this.isDisabled)return{borderColor:t,backgroundColor:t}},tabindex:function(){return this.isDisabled||"radio"===n&&!this.checked?-1:0}},methods:{onClick:function(t){var e=t.target,i=this.$refs.icon,n=i===e||i.contains(e);this.isDisabled||!n&&this.labelDisabled||this.toggle(),this.$emit("click",t)},genIcon:function(){var t=this.$createElement,e=this.checked,n=this.iconSize||this.parent&&this.parent.iconSize;return t("div",{ref:"icon",class:i("icon",[this.shape,{disabled:this.isDisabled,checked:e}]),style:{fontSize:Object(o["a"])(n)}},[this.slots("icon",{checked:e})||t(s["a"],{attrs:{name:"success"},style:this.iconStyle})])},genLabel:function(){var t=this.$createElement,e=this.slots();if(e)return t("span",{class:i("label",[this.labelPosition,{disabled:this.isDisabled}])},[e])}},render:function(){var t=arguments[0],e=[this.genIcon()];return"left"===this.labelPosition?e.unshift(this.genLabel()):e.push(this.genLabel()),t("div",{attrs:{role:n,tabindex:this.tabindex,"aria-checked":String(this.checked)},class:i({disabled:this.isDisabled,"label-disabled":this.labelDisabled}),on:{click:this.onClick}},[e])}}},d=Object(n["a"])("radio"),l=d[0],c=d[1];e["a"]=l({mixins:[r({bem:c,role:"radio",parent:"vanRadio"})],computed:{currentValue:{get:function(){return this.parent?this.parent.value:this.value},set:function(t){(this.parent||this).$emit("input",t)}},checked:function(){return this.currentValue===this.name}},methods:{toggle:function(){this.currentValue=this.name}}})},adba:function(t,e,i){},b4eb:function(t,e,i){i("a29f"),i("8a5a"),i("0607"),i("949e"),i("247c"),i("f251"),i("0958")},b650:function(t,e,i){"use strict";var n=i("c31d"),s=i("2638"),a=i.n(s),o=i("d282"),r=i("ba31"),d=i("b1d2"),l=i("48f4"),c=i("ad06"),u=i("543e"),h=Object(o["a"])("button"),p=h[0],f=h[1];function b(t,e,i,n){var s,o=e.tag,h=e.icon,p=e.type,b=e.color,g=e.plain,m=e.disabled,v=e.loading,A=e.hairline,C=e.loadingText,_={};function O(t){v||m||(Object(r["a"])(n,"click",t),Object(l["a"])(n))}function k(t){Object(r["a"])(n,"touchstart",t)}b&&(_.color=g?b:d["f"],g||(_.background=b),-1!==b.indexOf("gradient")?_.border=0:_.borderColor=b);var w=[f([p,e.size,{plain:g,loading:v,disabled:m,hairline:A,block:e.block,round:e.round,square:e.square}]),(s={},s[d["b"]]=A,s)];function S(){var n,s=[];return v?s.push(t(u["a"],{class:f("loading"),attrs:{size:e.loadingSize,type:e.loadingType,color:"currentColor"}})):h&&s.push(t(c["a"],{attrs:{name:h},class:f("icon")})),n=v?C:i.default?i.default():e.text,n&&s.push(t("span",{class:f("text")},[n])),s}return t(o,a()([{style:_,class:w,attrs:{type:e.nativeType,disabled:m},on:{click:O,touchstart:k}},Object(r["b"])(n)]),[S()])}b.props=Object(n["a"])({},l["c"],{text:String,icon:String,color:String,block:Boolean,plain:Boolean,round:Boolean,square:Boolean,loading:Boolean,hairline:Boolean,disabled:Boolean,nativeType:String,loadingText:String,loadingType:String,tag:{type:String,default:"button"},type:{type:String,default:"default"},size:{type:String,default:"normal"},loadingSize:{type:String,default:"20px"}}),e["a"]=p(b)},da53:function(t,e,i){"use strict";i.r(e);var n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"authorize_input_page",style:{height:t.bodyHeight+"px"}},[i("div",{staticClass:"top_title_group"},[i("van-icon",{staticClass:"arrow_left",attrs:{slot:"left",name:"arrow-left"},on:{click:t.onClickBack},slot:"left"}),i("span",{staticClass:"middle_text_content"},[t._v(t._s(t.middleTitleText))]),t.isShowRecord?i("span",{staticClass:"right_title_text",attrs:{name:"wap-nav"},on:{click:t.onClickRight}},[t._v(t._s(t.rightTitleText))]):t._e(),i("van-divider",{staticClass:"divider_line"})],1),i("div",{staticClass:"operation_choice_title_group"},[i("span",{staticClass:"operation_choice_title_content"},[t._v(t._s(t.$t("operationTypeSelect")))])]),i("div",{staticClass:"choice_group"},[i("van-radio-group",{staticClass:"choice_radio_group",model:{value:t.radioAuthBtnValue,callback:function(e){t.radioAuthBtnValue=e},expression:"radioAuthBtnValue"}},[i("van-radio",{staticClass:"auth_original",attrs:{name:t.AddAdmin,disabled:t.isDisableAddAdminRadio}},[t._v(" "+t._s(t.$t("addAdmin"))+" ")]),i("van-radio",{staticClass:"auth_cancel",attrs:{name:t.DeleteAdmin}},[t._v(t._s(t.$t("deleteAdmin")))])],1)],1),i("div",{staticClass:"address_choice_title_group"},[i("span",{staticClass:"address_choice_title_content"},[t._v(t._s(t.$t("chooseAdmin")))])]),i("div",{staticClass:"add_name_group"},[i("div",{staticClass:"address_group"},[i("van-cell-group",[i("van-field",{ref:"inputAddressValue",attrs:{label:t.$t("address"),disabled:t.isDisableInputAddress,"right-icon":t.addressRightIcon,placeholder:t.addressHintInfo,required:""},on:{"click-right-icon":t.clickAddressInput},model:{value:t.inputAddressValue,callback:function(e){t.inputAddressValue=e},expression:"inputAddressValue"}})],1)],1),i("div",{staticClass:"username_group"},[i("van-cell-group",[i("van-field",{ref:"inputName",attrs:{label:t.$t("username"),clearable:"",placeholder:t.$t("inputName"),disabled:t.isDisableInputName,required:""},model:{value:t.inputName,callback:function(e){t.inputName=e},expression:"inputName"}})],1)],1)]),i("div",{staticClass:"address_popup_group"},[i("van-popup",{staticClass:"popup_window_group",model:{value:t.isShowAddressPopup,callback:function(e){t.isShowAddressPopup=e},expression:"isShowAddressPopup"}},[i("van-picker",{staticClass:"addPicker",attrs:{"show-toolbar":"",columns:t.addressList,"default-index":t.addressList.length/2},on:{cancel:function(e){t.isShowAddressPopup=!1},confirm:t.confirmPickerAddress}})],1)],1),i("div",{staticClass:"choice_direction_group"},[i("div",{staticClass:"next_step_group",on:{click:t.nextStep}},[i("span",{staticClass:"next_text_class"},[t._v(t._s(t.$t("nextStep")))]),i("van-icon",{staticClass:"right_icon_class",attrs:{name:"arrow"}})],1)]),i("van-overlay",{attrs:{show:t.isLoadingAccount}},[i("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v(t._s(t.$t("dataLoading")))])],1)],1)},s=[],a=(i("c975"),i("b0c0"),i("d3b7"),i("ac1f"),i("25f0"),i("5319"),i("96cf"),i("c964")),o=i("276c"),r=i("e954"),d=i("e1a7"),l=i("f20d"),c=i("920b"),u=i("9ab4"),h=i("60a3"),p=i("565f"),f=i("b650"),b=i("9ffb"),g=i("d1e1"),m=i("34e96"),v=i("ad06"),A=i("d282"),C=i("b1d2"),_=i("9884"),O=i("2b0e"),k=i("1325"),w=function(t){return O["a"].extend({props:{closeOnClickOutside:{type:Boolean,default:!0}},data:function(){var e=this,i=function(i){e.closeOnClickOutside&&!e.$el.contains(i.target)&&e[t.method]()};return{clickOutsideHandler:i}},mounted:function(){Object(k["b"])(document,t.event,this.clickOutsideHandler)},beforeDestroy:function(){Object(k["a"])(document,t.event,this.clickOutsideHandler)}})},S=i("a8c1"),y=Object(A["a"])("dropdown-menu"),x=y[0],$=y[1],N=x({mixins:[Object(_["b"])("vanDropdownMenu"),w({event:"click",method:"onClickOutside"})],props:{activeColor:String,overlay:{type:Boolean,default:!0},zIndex:{type:Number,default:10},duration:{type:Number,default:.2},direction:{type:String,default:"down"},closeOnClickOverlay:{type:Boolean,default:!0}},data:function(){return{offset:0}},computed:{scroller:function(){return Object(S["d"])(this.$el)}},methods:{updateOffset:function(){var t=this.$refs.menu,e=t.getBoundingClientRect();"down"===this.direction?this.offset=e.bottom:this.offset=window.innerHeight-e.top},toggleItem:function(t){this.children.forEach((function(e,i){i===t?e.toggle():e.showPopup&&e.toggle(!1,{immediate:!0})}))},onClickOutside:function(){this.children.forEach((function(t){t.toggle(!1)}))}},render:function(){var t=this,e=arguments[0],i=this.children.map((function(i,n){return e("div",{attrs:{role:"button",tabindex:i.disabled?-1:0},class:$("item",{disabled:i.disabled}),on:{click:function(){i.disabled||t.toggleItem(n)}}},[e("span",{class:[$("title",{active:i.showPopup,down:i.showPopup===("down"===t.direction)}),i.titleClass],style:{color:i.showPopup?t.activeColor:""}},[e("div",{class:"van-ellipsis"},[i.slots("title")||i.displayTitle])])])}));return e("div",{ref:"menu",class:[$(),C["d"]]},[i,this.slots("default")])}}),D=i("1421"),I=i("7744"),R=i("e41f"),T=Object(A["a"])("dropdown-item"),j=T[0],B=T[1],P=j({mixins:[Object(D["a"])({ref:"wrapper"}),Object(_["a"])("vanDropdownMenu")],props:{value:null,title:String,disabled:Boolean,titleClass:String,options:{type:Array,default:function(){return[]}}},data:function(){return{transition:!0,showPopup:!1,showWrapper:!1}},computed:{displayTitle:function(){var t=this;if(this.title)return this.title;var e=this.options.filter((function(e){return e.value===t.value}));return e.length?e[0].text:""}},watch:{showPopup:function(t){this.bindScroll(t)}},beforeCreate:function(){var t=this,e=function(e){return function(){return t.$emit(e)}};this.onOpen=e("open"),this.onClose=e("close"),this.onOpened=e("opened")},methods:{toggle:function(t,e){void 0===t&&(t=!this.showPopup),void 0===e&&(e={}),t!==this.showPopup&&(this.transition=!e.immediate,this.showPopup=t,t&&(this.parent.updateOffset(),this.showWrapper=!0))},bindScroll:function(t){var e=this.parent.scroller,i=t?k["b"]:k["a"];i(e,"scroll",this.onScroll,!0)},onScroll:function(){this.parent.updateOffset()},onClickWrapper:function(t){this.getContainer&&t.stopPropagation()}},render:function(){var t=this,e=arguments[0],i=this.parent,n=i.zIndex,s=i.offset,a=i.overlay,o=i.duration,r=i.direction,d=i.activeColor,l=i.closeOnClickOverlay,c=this.options.map((function(i){var n=i.value===t.value;return e(I["a"],{attrs:{clickable:!0,icon:i.icon,title:i.text},key:i.value,class:B("option",{active:n}),style:{color:n?d:""},on:{click:function(){t.showPopup=!1,i.value!==t.value&&(t.$emit("input",i.value),t.$emit("change",i.value))}}},[n&&e(v["a"],{class:B("icon"),attrs:{color:d,name:"success"}})])})),u={zIndex:n};return"down"===r?u.top=s+"px":u.bottom=s+"px",e("div",[e("div",{directives:[{name:"show",value:this.showWrapper}],ref:"wrapper",style:u,class:B([r]),on:{click:this.onClickWrapper}},[e(R["a"],{attrs:{overlay:a,position:"down"===r?"top":"bottom",duration:this.transition?o:0,closeOnClickOverlay:l,overlayStyle:{position:"absolute"}},class:B("content"),on:{open:this.onOpen,close:this.onClose,opened:this.onOpened,closed:function(){t.showWrapper=!1,t.$emit("closed")}},model:{value:t.showPopup,callback:function(e){t.showPopup=e}}},[c,this.slots("default")])])])}}),V=i("9f14"),L=i("e27c"),z=i("d399"),W=i("6e47"),H=i("543e"),M=i("6b41"),E=i("f253"),J=(i("fdc4"),i("0147"),i("17d1"),i("1885"),i("681e"),i("0662"),i("b4eb"),i("339f"),i("7597"),i("2477"),i("c2d8"),i("e815"),i("b657"),i("9a5b"),i("5b4d"),i("36d1")),q=i("5487"),Q=i("7c42"),U=i("8402"),X=i("ac6d"),G=i("bb62");h["c"].use(p["a"]).use(f["a"]).use(b["a"]).use(g["a"]).use(m["a"]).use(v["a"]).use(N).use(P).use(V["a"]).use(L["a"]).use(z["a"]).use(W["a"]).use(H["a"]).use(M["a"]).use(E["a"]);var K=function(t){function e(){var t;return Object(o["a"])(this,e),t=Object(d["a"])(this,Object(l["a"])(e).apply(this,arguments)),t.bodyHeight=0,t.inputName="",t.inputAddressValue="",t.middleTitleText="",t.rightTitleText="",t.isLoadingAccount=!0,t.isDisableInputAddress=!1,t.isDisableInputName=!1,t.isShowAddressPopup=!1,t.isShowRecord=!1,t.addressList=Array(),t.isDisableAddAdminRadio=!1,t.addressHintInfo="",t.AddAdmin=J["a"].AddAdmin,t.DeleteAdmin=J["a"].DeleteAdmin,t.radioAuthBtnValue=J["a"].None,t.SeparateSymbol=";",t.addressRightIcon=G["a"].ICON_ARROW_DOWN,t}return Object(c["a"])(e,t),Object(r["a"])(e,[{key:"created",value:function(){this.$store.state.title=this.$t("managerSetting"),this.middleTitleText=this.$t("managerSetting").toString(),this.rightTitleText=this.$t("authRecord").toString(),this.bodyHeight=document.documentElement.clientHeight,window.nativeQrScanToJsResult=this.nativeQrScanToJsResult}},{key:"mounted",value:function(){var t=Object(a["a"])(regeneratorRuntime.mark((function t(){var e,i,n,s;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(e=[],null!==G["a"].loadContractAddress()&&""!==G["a"].loadContractAddress()){t.next=5;break}return Q["a"].show(this.$t("contractAddressIsNull").toString()),this.isLoadingAccount=!1,t.abrupt("return");case 5:return t.prev=5,t.next=8,q["b"].getInstance().loadOriginalList(this.$store.state.nativeChainAddress);case 8:e=t.sent,this.isLoadingAccount=!1,t.next=17;break;case 12:return t.prev=12,t.t0=t["catch"](5),this.isLoadingAccount=!1,Q["a"].show(this.$t("unknownErrorPlsRecheck").toString()),t.abrupt("return");case 17:if(0!==e.length){t.next=20;break}return Q["a"].show(this.$t("emptyChainData").toString()),t.abrupt("return");case 20:for(console.log("columns.length :"+e.length),e.length===G["a"].MAX_ADMIN_COUNT?(this.addressHintInfo=this.$t("plsChooseAddress").toString(),this.isDisableInputAddress=!0,this.isDisableInputName=!0,this.isDisableAddAdminRadio=!0,this.radioAuthBtnValue=this.DeleteAdmin,this.addressRightIcon=G["a"].ICON_ARROW_DOWN):(this.addressHintInfo=this.$t("plsChooseOrInputAddress").toString(),this.isDisableInputAddress=!1,this.radioAuthBtnValue=this.AddAdmin,this.addressRightIcon=G["a"].ICON_SCAN),this.$store.commit("emptyOriginalAddress"),i=0;i<e.length;i++)n=i,this.addressList.push(e[n].name+this.SeparateSymbol+e[n].address),s=e[n],this.$store.commit("addOriginalAddressModel",s),e[n].address.toLowerCase()===this.$store.state.nativeChainAddress.toLowerCase()&&(this.isShowRecord=!0);case 24:case"end":return t.stop()}}),t,this,[[5,12]])})));function e(){return t.apply(this,arguments)}return e}()},{key:"onClickBack",value:function(){this.$router.replace({name:"cert_search"})}},{key:"onClickRight",value:function(){this.$router.push({name:"auth_admin_record"})}},{key:"nextStep",value:function(){if(this.addressList.length!==G["a"].MAX_ADMIN_COUNT-1||this.radioAuthBtnValue!==this.DeleteAdmin)if(this.radioAuthBtnValue===this.AddAdmin||this.radioAuthBtnValue===this.DeleteAdmin)if(this.inputAddressValue&&this.inputName){var t=new J["b"];t.targetTxName=this.inputName,t.targetTxAddress=this.inputAddressValue,t.nowAdminAddress=this.$store.state.nativeChainAddress,console.log("entry page authTx.nowAdminAddress===>"+t.nowAdminAddress+"||"+this.$store.state.nativeChainAddress),this.radioAuthBtnValue===this.AddAdmin?t.authType=J["a"].AddAdmin:t.authType=J["a"].DeleteAdmin,this.$store.commit("updateAdminModel",t),this.$router.push({name:"original/confirm"})}else Q["a"].show(this.$t("inputNotNull").toString());else Q["a"].show(this.$t("operationTypeSelect").toString());else Q["a"].fail(this.$t("forbidDeleteAdmin").toString())}},{key:"clickAddressInput",value:function(){this.AddAdmin===this.radioAuthBtnValue?U["a"].getInstance().callNativeQrScanToJs():this.isShowAddressPopup=!0}},{key:"confirmPickerAddress",value:function(t){if(this.isShowAddressPopup=!1,t){var e=t.indexOf(this.SeparateSymbol);this.inputName=t.substring(0,e),this.inputAddressValue=t.substring(e+1,t.length);var i=new J["b"];i.targetTxName=this.inputName,i.targetTxAddress=this.inputAddressValue}}},{key:"Change",value:function(t,e){t===this.AddAdmin&&t!==e&&(this.inputAddressValue="",this.inputName=""),this.$store.state.authOriginalTxModel.originalAddressModelList.length===G["a"].MAX_ADMIN_COUNT?(this.isDisableAddAdminRadio=!0,this.addressRightIcon=G["a"].ICON_ARROW_DOWN):(this.isDisableAddAdminRadio=!1,t===this.AddAdmin?this.addressRightIcon=G["a"].ICON_SCAN:this.addressRightIcon=G["a"].ICON_ARROW_DOWN)}},{key:"nativeQrScanToJsResult",value:function(t){this.inputAddressValue="",this.inputAddressValue=t,Object(X["a"])(t)||Q["a"].fail("不符合标准地址格式，请您再检查地址信息")}}]),e}(h["c"]);Object(u["a"])([Object(h["d"])("radioAuthBtnValue",{immediate:!0,deep:!0})],K.prototype,"Change",null),K=Object(u["a"])([Object(h["a"])({})],K);var F=K,Y=F,Z=(i("1fde"),i("2877")),tt=Object(Z["a"])(Y,n,s,!1,null,"241dfdf8",null);e["default"]=tt.exports},dfda:function(t,e,i){},e27c:function(t,e,i){"use strict";var n=i("d282"),s=i("9884"),a=Object(n["a"])("radio-group"),o=a[0],r=a[1];e["a"]=o({mixins:[Object(s["b"])("vanRadio")],props:{value:null,disabled:Boolean,checkedColor:String,iconSize:[Number,String]},watch:{value:function(t){this.$emit("change",t)}},render:function(){var t=arguments[0];return t("div",{class:r(),attrs:{role:"radiogroup"}},[this.slots()])}})}}]);
//# sourceMappingURL=chunk-1406805e.d1edb158.js.map