/* automatically generated by rust-bindgen 0.55.1 */
#![allow(non_snake_case)]
#![allow(dead_code)]

extern "C" {
    pub fn add(a: ::std::os::raw::c_int, b: ::std::os::raw::c_int) -> ::std::os::raw::c_int;
}

extern "C" {
    pub fn addStr(cs: *mut ::std::os::raw::c_char) -> *mut ::std::os::raw::c_char;
}

extern "C" {
    pub fn Str_free(cs: *mut ::std::os::raw::c_char);
}

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct Data {
    pub intType: ::std::os::raw::c_int,
    pub charType: *mut ::std::os::raw::c_char,
    pub arrayInt: *mut ::std::os::raw::c_int,
    pub arrayIntLength: ::std::os::raw::c_ulonglong,
    pub arrayData: *mut Data,
    pub arrayDataLength: ::std::os::raw::c_ulonglong,
    pub pointData: *mut Data,
}

#[test]
fn bindgen_test_layout_Data() {
    assert_eq!(
        ::std::mem::size_of::<Data>(),
        56usize,
        concat!("Size of: ", stringify!(Data))
    );
    assert_eq!(
        ::std::mem::align_of::<Data>(),
        8usize,
        concat!("Alignment of ", stringify!(Data))
    );
    assert_eq!(
        unsafe { &(*(::std::ptr::null::<Data>())).intType as *const _ as usize },
        0usize,
        concat!(
        "Offset of field: ",
        stringify!(Data),
        "::",
        stringify!(intType)
        )
    );
    assert_eq!(
        unsafe { &(*(::std::ptr::null::<Data>())).charType as *const _ as usize },
        8usize,
        concat!(
        "Offset of field: ",
        stringify!(Data),
        "::",
        stringify!(charType)
        )
    );
    assert_eq!(
        unsafe { &(*(::std::ptr::null::<Data>())).arrayInt as *const _ as usize },
        16usize,
        concat!(
        "Offset of field: ",
        stringify!(Data),
        "::",
        stringify!(arrayInt)
        )
    );
    assert_eq!(
        unsafe { &(*(::std::ptr::null::<Data>())).arrayIntLength as *const _ as usize },
        24usize,
        concat!(
        "Offset of field: ",
        stringify!(Data),
        "::",
        stringify!(arrayIntLength)
        )
    );
    assert_eq!(
        unsafe { &(*(::std::ptr::null::<Data>())).arrayData as *const _ as usize },
        32usize,
        concat!(
        "Offset of field: ",
        stringify!(Data),
        "::",
        stringify!(arrayData)
        )
    );
    assert_eq!(
        unsafe { &(*(::std::ptr::null::<Data>())).arrayDataLength as *const _ as usize },
        40usize,
        concat!(
        "Offset of field: ",
        stringify!(Data),
        "::",
        stringify!(arrayDataLength)
        )
    );
    assert_eq!(
        unsafe { &(*(::std::ptr::null::<Data>())).pointData as *const _ as usize },
        48usize,
        concat!(
        "Offset of field: ",
        stringify!(Data),
        "::",
        stringify!(pointData)
        )
    );
}

extern "C" {
    pub fn Data_new() -> *mut Data;
}

extern "C" {
    pub fn Data_free(cd: *mut Data);
}

extern "C" {
    pub fn Data_use(cd: *mut Data) -> *mut Data;
}
