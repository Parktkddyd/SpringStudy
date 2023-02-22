<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<form role="form" action="modifyPage" method="post">
		<input type='hidden' name='bno' value="${boardVO.bno }">
		<input type='hidden' name='page' value="${cri.page }">
		<input type='hidden' name='perPageNum' value="${cri.perPageNum }">
		<input type='hidden' name='searchType' value="${cri.searchType }">
		<input type='hidden' name='keyword' value="${cri.keyword }">
	</form>
	
	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail">Title</label>
			<input type="text" name='title' class="form-control" value="${boardVO.title }" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
			<textarea class="form-control" name="content" rows="3" readonly="readonly">${boardVO.content }</textarea>
		</div>
		<div class="form-group">
			<label for="exampleEmail1">Writer</label>
			<input type="text" name="writer" class="form-control" value="${boardVO.writer }" readonly="readonly">
		</div>		
	</div><!--/.box-body  -->
	
	<div class="box-footer">
		<button type="submit" class="btn btn-warning">Modify</button>
		<button type="submit" class="btn btn-danger">REMOVE</button>
		<button type="submit" class="btn btn-primary">LIST ALL</button>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				<div class="box-body">
					<label for="newReplyWriter">Writer</label>
						<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter">
					<label for="newReplyText">ReplyText</label>
						<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
						
				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- The time line -->
	<ul class="timeline">
		<!-- timeline time label -->
		<li class="time-label" id="repliesDiv"><span class="bg-green"> Replies List</span></li>
	</ul>
	
	<div class="text-center">
		<ul id="pagination" class="pagination pagination-sm no-margin"></ul>
	</div>
</body>
<%@ include file="../include/footer.jsp" %>
<script>
	$(document).ready(function(){
		var formObj = $("form[role='form']");
		
		console.log(formObj);
		
		$(".btn-warning").on("click", function(){
			formObj.attr("action", "/sboard/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		$(".btn-danger").on("click", function(){
			formObj.attr("method", "post");
			formObj.attr("action", "/sboard/removePage");
			formObj.submit();
		});
		
		$(".btn-primary").on("click", function(){
			formObj.attr("method", "get");
			formObj.attr("action", "/sboard/list");
			formObj.submit();
		});
		
	});
</script>

<script id="template" type="text/x-handlebars-tempate">
	{{#each .}}
	<li class="replyLi data-rno={{rno}}>
	<i class="fa fa-comments-bg-blue"></i>
	<div class="timeline-item">
		<span class="time">
			<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
		</span>
		<h3 class="timeline-header"><strong>{{rno}}</strong> - {{replyer}}</h3>
		<div class="timeline-body">{{replytext}}</div>
			<div class="timeline-footer">
			<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
			</div>
	</div>
	</li>		
	{{/each}}
</script>
	
<script>
		
		Handlebars.registerHepler("prettifyDate", function(timeValue){
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year + "/" + month + "/" date;
		});
		
		var printData = function (replyArr, target, templateObject){
			
			var template = Handlebars.compile(templateObject.html());
			
			var html = template(replyArr);
			$(".replyLi").remove();
			target.after(html);
		}
</script>

<script>
	var bno = ${boardVO.bno};
	var replyPage = 1;
	
	function getPage(pageInfo){
		
		$.getJSON(pageInfo, function(data){
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));
		});
	}
	
	var printPaging = function(pageMaker, target){
		
		var str = "";
		
		if(pageMaker.prev){
			str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
		}
		
		for(var i=pageMaker.startPage, len=pageMaker.endPage; i<=len; i++){
			var strClass = pageMaker.cri.page == i?'class=active':'';
			str += "<li +strClass+"><a href = '"+i+"'>"+i+"</a></li>";
		}
		
		if(pageMaker.next){
			str += "<li><a href='"+(pageMaker.endPage+1)+"'> >> </a></li>";
		}
		
		target.html(str);
	}
</script>

</html>