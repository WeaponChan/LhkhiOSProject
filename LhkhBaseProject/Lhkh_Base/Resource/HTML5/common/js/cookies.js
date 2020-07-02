
function getLocalStorage(name, isEncode){
    let storage = localStorage.getItem(name);
    if (isEncode) {
        storage = decodeURI(storage);
    }
    if(!storage||storage=='null'){
        setLocalStorage();
        storage = localStorage.getItem(name);
    }
    return storage;
}
function setLocalStorage(name, value, isEncode) {
    if (isEncode&&value) {
        value = encodeURI(value);
    }
    if(value){
        localStorage.setItem(name, value);
    }
}











