
<!DOCTYPE html>
<html>
<head>
<meta charset="UTP-8">
<title>다운로드 팝업</title>
<link rel="stylesheet" href="./upload_board.css">
</head>
<body>
  
  
<div class="fileUploader">
    <table class="fileUploader_container fileUploader_download">
        <thead>
            <tr>
                <th class="fileup_check"><input type="checkbox" onclick="" id="cheack_All" />
                    <label for="cheack_All"><b>첨부파일 전체 선택</b></label>
                </th>
                <th class="fileup_name">파일명</th>
                <th class="fileup_size">크기</th>
                <th class="down_hit">다운횟수</th>
            </tr>
        </thead>
        <tbody>
			<tr class="upload_file">
				<td class="fileup_check"><input type="checkbox" onclick="" title="첨부파일 선택" id="upload_file_0" /></td>
				<td class="fileup_name"><label for="upload_file_0"><img src="./images/icon_pdf.png" alt="" /> 확장자랑 첨부된 파일 명.pdf</label></td>
				<td class="fileup_size">60.02KB</td>
				<td class="down_hit">1 회</td>
			</tr>
			<tr class="upload_file">
				<td class="fileup_check"><input type="checkbox" onclick="" title="첨부파일 선택" id="upload_file_1" /></td>
				<td class="fileup_name"><label for="upload_file_1"><img src="./images/icon_docx.png" alt="" /> 확장자랑 첨부된.docx</label></td>
				<td class="fileup_size">60.02KB</td>
				<td class="down_hit">0 회</td>
			</tr>
			<tr  class="upload_file">
				<td class="fileup_check"><input type="checkbox" onclick="" title="첨부파일 선택" id="upload_file_2" /></td>
				<td class="fileup_name"><label for="upload_file_2"><img src="./images/icon_hwp.png" alt="" /> adasdasdasdasddad1231a4.hwp</label></td>
				<td class="fileup_size">60.02KB</td>
				<td class="down_hit">1 회</td>
			</tr>
        </tbody>
    </table>
    
	<div class="fileUploader_downbox">
        <button class="download_file">선택한 파일 다운로드</button>
        <span class="uploadfile_info">파일 3개 | 2 MB</span>
    </div>
</div>



<div class="file_transferring">
	<div class="filetrans_header">
    	<p class="top_text">파일을 다운로드 하는 중 입니다.</p>
        <p class="top_close_btn"><a href="#none">닫기</a></p>
    </div>
    <div class="filetrans_bar_box">
    	<div class="filetrans_bar">
        	<div class="filetrans_bar_exp" style="width:65.5%;"></div>
        	<p class="filetrans_size">25468.0 KB / 50 MB (64.5%)</p>
            <p class="filetrans_time_info">00:00:19 (2.00 KB/s)</p>
        </div>
        <p class="filetrans_list">LTSKOREA_LOGO.png + 1 file </p>
    </div>
</div>   
    
    
    
</body>
</html>