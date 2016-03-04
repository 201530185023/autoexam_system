<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="top.moyuyc.entity.Ques" %>
<%@ page import="top.moyuyc.jdbc.QuesAcess" %>
<%@ page import="top.moyuyc.tools.Tools" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="net.sf.json.JSONObject" %>
<%--
  Created by IntelliJ IDEA.
  User: Yc
  Date: 2015/9/17
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="error.jsp"%>
<%if (session.getAttribute("username") == null) {
        response.sendRedirect("?reg");
        return;
    }
    boolean f = true;
    String con = null, order = null, content = null;
    int pag = 1;
    boolean isAsc = true;
    Boolean isCertain = null;
    int pageSize = 15;
    try {
        con = Tools.ParToStr(request.getParameter("searchCon"));
        isCertain = Boolean.parseBoolean(Tools.ParToStr(request.getParameter("isCertain")));
        pag = Integer.parseInt(Tools.ParToStr(request.getParameter("page")));
        order = Tools.ParToStr(request.getParameter("order"));
        if (!order.equals("id"))
            order = "ques_" + order;
        isAsc = Boolean.parseBoolean(Tools.ParToStr(request.getParameter("isAsc")));
        content = Tools.ParToStr(request.getParameter("content"));

        if (con == null || order == null || content == null || !order.equals("ques_subject")
                || !order.equals("id") || !order.equals("ques_type") || !con.equals("ques_Id")
                || !con.equals("ques_Subject") || !con.equals("ques_Content") || !con.equals("ques_Analy"))
            throw new Exception();
    } catch (Exception e) {
        //response.sendRedirect(defaultUrl);
        e.printStackTrace();
    }
    List<Ques> list = null;
    try {
        if (con.equals("ques_Id")) {
            list = QuesAcess.getQuessById(content, pag, pageSize, order, isAsc, isCertain);
        } else if (con.equals("ques_Subject")) {
            list = QuesAcess.getQuessBySubject(content, pag, pageSize, order, isAsc, isCertain);
        } else if (con.equals("ques_Content")) {
            list = QuesAcess.getQuessByContent(content, pag, pageSize, order, isAsc);
        } else {
            list = QuesAcess.getQuessByAnaly(content, pag, pageSize, order, isAsc);
        }
    } catch (Exception e) {
        //response.sendRedirect(defaultUrl);
        e.printStackTrace();
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/jquery-ui.min.css">
    <link rel="stylesheet" href="css/jquery.resizableColumns.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="Shortcut Icon" href="images/ico.ico" type="image/x-icon" />
    <script src="js/header.js"></script>
    <script src="js/jquery.resizableColumns.js"></script>
    <script src="js/jquery.tablesorter.min.js"></script>
    <script src="js/store.js"></script>
    <title>题目搜索 · 考友无忧</title>
</head>
<body>
<jsp:include page="template/header.jsp">
    <jsp:param name="way" value="search"></jsp:param>
</jsp:include>
<div class="container">
    <div class="progress">
        <div id="search_progress" class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="1"
             aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
            <span class="sr-only">progress</span>
        </div>
    </div>
    <div class="table-responsive">
    <table id="search_table"  class="tablesorter table-bordered">
        <caption>搜索结果</caption>
        <span class='text-danger'>小提示：点击表头可排序查看哦！表格列宽也可以动态调整！</span>
        <thead>
        <tr>
            <th data-resizable-column-id="题号">题号</th>
            <th data-resizable-column-id="科目">科目</th>
            <th data-resizable-column-id="类型">类型</th>
            <th data-resizable-column-id="分值">分值</th>
            <th data-resizable-column-id="难度">难度</th>
            <th data-resizable-column-id="内容">内容</th>
            <th data-resizable-column-id="答案">答案</th>
            <th data-resizable-column-id="解析">解析</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        </tbody>
    </table>
    </div>
    <hr>
    <nav>
        <ul class="pager" <%if(list==null){%>style="display: none;"<%}%>>
            <li><a style="border-radius: 0" href="javascript:;" id="pre_page"><<</a></li>
            <li><a style="border-radius: 0" href="javascript:;" class="active" id="cur_page">1</a></li>
            <li><a style="border-radius: 0" href="javascript:;" id="next_page">>></a></li>
        </ul>
    </nav>
</div>

<jsp:include page="template/footer.jsp"></jsp:include>
</body>
</html>
<script>
    $(document).ready(function () {
        var search_info;
        $("#cur_page").text(<%=pag%>)
        $("#pre_page").click(function () {
            if ($("#cur_page").text() == 1)
                return;
            if (search_info == null) return;
            var temp=search_info
            temp.page = Number($("#cur_page").text() - 1)
            $.ajax({
                method: "GET",
                url: "ajax/start",
                data: temp
            }).done(function (d) {
                if (d == -1)
                    $("#pre_page").popover({
                        html:true,
                        trigger:'manual',
                        content:"<span style='color:red'><span class='glyphicon glyphicon-remove'></span> 无数据</span>",
                        container:'body'
                    }).popover('show')
                else{
                    $("#search_progress").animate({width: "100%"}, 100, null, function () {
                        $("#search_table").quesTableShow(d)
                    })
                    search_info=temp
                    $("#cur_page").text(temp.page)
                }
            })
        })
        $("#next_page").click(function () {
            if (search_info == null) return;
            var temp=search_info
            temp.page = Number($("#cur_page").text()) + 1
            $.ajax({
                method: "GET",
                url: "ajax/start",
                data: temp
            }).done(function (d) {
                if (d == -1)
                    $("#next_page").popover({
                        html:true,
                        trigger:'manual',
                        content:"<span style='color:red'><span class='glyphicon glyphicon-remove'></span> 无数据</span>",
                        container:'body'
                    }).popover('show').on("shown.bs.popover",function(){
                        var t=$(this)
                        setTimeout(function(){
                            t.popover('hide')
                        },1500)
                    })
                else{
                    $("#search_progress").animate({width: "100%"}, 100, null, function () {
                        $("#search_table").quesTableShow(d)
                    })
                    search_info=temp
                    $("#cur_page").text(temp.page)
                }
            })
        })
        $("#search_progress").css("width", "100%")
        search_info=<%
            Map map=new HashMap<String,String>();
            map.put("act","userSearch");map.put("isCertain",isCertain);
            map.put("searchCon",con);map.put("content",content);
            map.put("page",pag);map.put("isAsc",isAsc);
            map.put("order",order);map.put("pageSize",pageSize);
            %><%=JSONObject.fromObject(map)%>
        $("#search_table").quesTableShow(<%if(list==null){%>-1<%}else{%><%=JSONArray.fromObject(list)%><%}%>)
        $("#search_btn").off("click");
        $("#search_btn").click(function (e, a) {
            console.log(a)
            if (trim($("#search_input").val()) == "") {
                $("#search_input").popover({
                    html: true,
                    content: "<span style='color: red'><span class='glyphicon glyphicon-remove'></span>请输入</span>",
                    trigger: 'manual',
                    placement: 'bottom',
                    container:'body'
                }).popover('show')
                return;
            }
            $("#search_progress").removeClass("progress-bar-success")
            $("#search_progress").removeClass("progress-bar-danger")
            $("#search_progress").hide().animate({width: '0%'}, 100, null,
                    function () {
                        $("#search_progress").show().animate({width: '95%'})
                    }
            );
            var isCertain = trim($("#search_way").text()) == "模糊" ? false : true;
            var con;
            switch (trim($("#search_content").text())) {
                case "题号":
                    con = "ques_Id";
                    break;
                case "内容":
                    con = "ques_Content";
                    break;
                case "解析":
                    con = "ques_Analy";
                    break;
                case "科目":
                    con = "ques_Subject";
                    break;
            }
            search_info = {
                act: 'userSearch',
                isCertain: isCertain,
                searchCon: con,
                content: trim($("#search_input").val()),
                //
                page: 1,
                isAsc: true,
                order: 'subject',
                pageSize: 15
            }
            $(this).prop("disabled",true);
            $.ajax({
                method: "GET",
                url: "ajax/start.jsp",
                data: search_info
            }).done(function (d) {
                setTimeout(function () {
                    $("#search_btn").prop("disabled",false);
                    $("#search_progress").animate({width: "100%"}, 100, null, function () {
                        $("#search_table").quesTableShow(d);
                        $("#search_table").find("th").addClass("header")
                    })
                    $("#cur_page").text(1)
                    if(d==-1){
                        $("[class=pager]").hide("normal")
                    }else
                        $("[class=pager]").show("normal")
                }, 1200)

            })
        })
    })

    $.fn.quesTableShow = function (data) {

        var caption = $(this).find("caption")
        var head = $(this).find("thead")
        var body = $(this).find("tbody")
        body.html("")
        if (data == -1) {
            $("#search_progress").removeClass("progress-bar-success")
            $("#search_progress").addClass("progress-bar-danger")
            head.show().hide("normal")
            body.show().hide("normal")
            caption.text("无搜索结果").css("color", "red").show("normal")
        } else {
            $("#search_progress").removeClass("progress-bar-danger")
            $("#search_progress").addClass("progress-bar-success")
            data = eval(data)
            caption.html("搜索结果  本页共有 <label class='text-info'>" + data.length + "</label> 条记录").css("color", "").show("normal")
            head.hide().show("normal")
            body.hide().show("normal")
            for (var i in data) {
                body.append($(getQuesTr(data[i])))
            }
            $("table").resizableColumns()
            $("table").trigger("update")//.trigger("sorton",[[0,0]]);
            $("table th").removeClass("headerSortDown").removeClass("headerSortUp")
        }
    }
    $("table").tablesorter()
    function getQuesTr(data) {
        var tr = document.createElement("tr");
        var td, td1, td2, td3, td4, td5, td6,tdLev;
        td = document.createElement("td");
        td.innerHTML = data.id

        tr.appendChild(td)
        td1 = document.createElement("td");
        td1.innerHTML = data.ques_subject;

        tr.appendChild(td1)
        td2 = document.createElement("td");
        var t;
        if (data.ques_type == 'single_choose')
            t = '单选'
        else if (data.ques_type == 'muti_choose')
            t = '多选'
        else if (data.ques_type == 'judgement')
            t = '判断'
        else
            t = '简答'
        td2.innerHTML = t;

        tr.appendChild(td2)
        td3 = document.createElement("td");
        td3.innerHTML = data.ques_score;
        tr.appendChild(td3)
        console.log(data)
        tdLev=document.createElement("td");
        var lev;
        switch (data.lev){
            case 0:lev='★★★'; break;
            case 1:lev='★★'; break;
            case 2:lev='★'; break;
        }
        tdLev.innerHTML = lev;
        tr.appendChild(tdLev);

        td4 = document.createElement("td");
        if (data.ques_type != 'muti_choose' && data.ques_type != 'single_choose')
            td4.innerHTML = data.ques_content.length == 0 ? "无" : data.ques_content;
        else {
            td4.innerHTML = data.ques_content.length == 0 ? "无" : getQuesSelect(data.ques_content).outerHTML;
        }
        tr.appendChild(td4)
        td5 = document.createElement("td");
        td5.innerHTML = data.ques_answer.length == 0 ? '无' : data.ques_answer;

        tr.appendChild(td5)
        td6 = document.createElement("td");
        td6.innerHTML = data.ques_analy == "" ? '无' : data.ques_analy;

        tr.appendChild(td6)
        return tr;
    }
    function getQuesSelect(data) {
        var sel = document.createElement('select');

        sel.style.width="100%"

        var s = '题ABCDEFGHIJK'
        for (var i in data) {
            var op = document.createElement('option');
            op.innerHTML = s.charAt(i) + '. ' + data[i]
            sel.appendChild(op)
        }

        return sel;
    }
</script>
