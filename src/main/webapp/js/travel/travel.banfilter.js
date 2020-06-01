function validateSentence(sentence) {
	var isValid = false;
   	var reqUrl = "/seantour_map/travel/banfilter/validation.do";
	var formData = "wordList=" + sentence;
    var promise = getAsyncValidation(reqUrl, formData);
    promise.success(function (data) {
    	// console.log(data); //return;
        isValid = (data === 'true');
    });
    return isValid;
}
function getAsyncValidation(reqUrl, formData) {
    return $.ajax({
        type: "GET"
        , url: reqUrl
        , data:encodeURI(formData)
        , cache:false
        , async: false
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , error: function(data, status, err) { 
            console.log("data", data);
            console.log("status", status);
            console.log("err", err);
            // alert('서버와의 통신이 실패했습니다.');
        }
    });
}
