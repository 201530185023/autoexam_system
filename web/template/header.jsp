<%@ page import="top.moyuyc.jdbc.QuesAcess" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Collections" %>
<%
    List<String> subject_list=QuesAcess.getAllSubs();
    subject_list=subject_list==null?new LinkedList<String>():subject_list;
    Collections.sort(subject_list);
    String way=request.getParameter("way");
    way= way==null?"":way;
%>
<link rel="stylesheet" href="assets/css/amazeui.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="js/moyuDialog/dialog.js"></script>
<script src="js/cookie.js"></script>
<style>
.tigger1 {
    transform: rotate(180deg);
}
</style>
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <div class="navbar-header" >
            <button type="button" id="phone-btn" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#header" aria-expanded="false" aria-controls="header">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a name="forteacher" class="navbar-brand hidden-sm" href="index"><span class="glyphicon glyphicon-book"></span> 考友无忧</a>
        </div>
        <div id="header" class="navbar-collapse collapse" aria-expanded="false">
            <ul class="nav navbar-nav hidden-xs hidden-sm hidden-md">
                <li id="choosed_subject">
                    <a href="#" role="button" aria-haspopup="true" aria-expanded="false">
                        科目 <span class="glyphicon glyphicon-chevron-up" style="transition: all 0.3s ease-in;" id="subjectstag"></span></a>
                    <ul id="subject_select" class="dropdown-menu">
                        <%for(int i=0;i<subject_list.size();i++){%>
                        <li><a href="javascript:;"><%=subject_list.get(i)%></a></li>
                        <%}%>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <%if(way.equals("index")){%>
                <li><a href="test"><span class="glyphicon glyphicon-pencil"></span> 我要考试</a></li>
                <li><a href="history"><span class="glyphicon glyphicon-time"></span> 考试记录</a></li>
                <li><a href="userinfo"><span class="glyphicon glyphicon-cog"></span> 个人设置</a></li>
                <li><a href="friend"><i class="am-icon-group"></i> 考友互动</a></li>
                <%}else if(way.equals("history")){%>
                <li><a href="test"><span class="glyphicon glyphicon-pencil"></span> 我要考试</a></li>
                <li class="active"><a href="history"><span class="glyphicon glyphicon-time"></span> 考试记录</a></li>
                <li><a href="userinfo"><span class="glyphicon glyphicon-cog"></span> 个人设置</a></li>
                <li><a href="friend"><i class="am-icon-group"></i> 考友互动</a></li>
                <%}else if(way.equals("test")){%>
                <li class="active"><a href="test"><span class="glyphicon glyphicon-pencil"></span> 我要考试</a></li>
                <li><a href="history"><span class="glyphicon glyphicon-time"></span> 考试记录</a></li>
                <li><a href="userinfo"><span class="glyphicon glyphicon-cog"></span> 个人设置</a></li>
                <li><a href="friend"><i class="am-icon-group"></i> 考友互动</a></li>
                <%}else if(way.equals("userinfo")){%>
                <li><a href="test"><span class="glyphicon glyphicon-pencil"></span> 我要考试</a></li>
                <li><a href="history"><span class="glyphicon glyphicon-time"></span> 考试记录</a></li>
                <li class="active"><a href="userinfo"><span class="glyphicon glyphicon-cog"></span> 个人设置</a></li>
                <li><a href="friend"><i class="am-icon-group"></i> 考友互动</a></li>
                <%}else if(way.equals("friend")){%>
                <li><a href="test"><span class="glyphicon glyphicon-pencil"></span> 我要考试</a></li>
                <li><a href="history"><span class="glyphicon glyphicon-time"></span> 考试记录</a></li>
                <li><a href="userinfo"><span class="glyphicon glyphicon-cog"></span> 个人设置</a></li>
                <li class="active"><a href="friend"><i class="am-icon-group"></i> 考友互动</a></li>
                <%}else{%>
                <li><a href="test"><span class="glyphicon glyphicon-pencil"></span> 我要考试</a></li>
                <li><a href="history"><span class="glyphicon glyphicon-time"></span> 考试记录</a></li>
                <li><a href="userinfo"><span class="glyphicon glyphicon-cog"></span> 个人设置</a></li>
                <li><a href="friend"><i class="am-icon-group"></i> 考友互动</a></li>
                <%}%>
            <%--</ul>--%>
            <%if(session.getAttribute("username")==null){%>
            <form class="navbar-form navbar-right">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#loginModal">登录</button>
                <button type="button" id="reg_btn" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target=".bs-example-modal-lg">注册</button>
            </form>
            <%}else{%>
            <form class="navbar-form navbar-right" role="form">
                <div class="form-group">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button id="search_way" type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            模糊 <span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <li><a href="#">模糊</a></li>
                            <li><a href="#">精确</a></li>
                        </ul>
                    </div>
                    <div class="input-group-btn">
                        <button id="search_content" type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            题号 <span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <li><a href="#">题号</a></li>
                            <li><a href="#">内容</a></li>
                            <li><a href="#">解析</a></li>
                            <li><a href="#">科目</a></li>
                        </ul>
                    </div>
                    <input type="text" id="search_input" placeholder="题目搜索" class="form-control" aria-label="...">
                    <span class="input-group-btn">
                        <button id="search_btn" class="btn btn-default" type="button">
                            &nbsp;<span class="glyphicon glyphicon-search"></span>&nbsp;
                        </button>
                    </span>
                </div>
                </div>
                <button id="exit_btn" type="button" class="btn btn-danger" href="javascript:;"> &nbsp;<span class="glyphicon glyphicon-off" ></span>&nbsp;</button>
            </form>
            </ul>

                <script>
                    $(document).ready(function () {
                        $("#search_input").keydown(function(e){
                            console.log(e.keyCode)
                            if(e.keyCode==13) {
                                $("#search_btn").click();
                                return false//否则不能跳转页面
                            }
                        })
                    })

                </script>
            <%}%>
        </div><!--/.nav-collapse -->
    </div>
</nav>

<!--警告-->
<div id="alert" style="display: none" >
<div class="alert alert-danger alert-dismissible fade in form-inline navbar-right" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
    <p></p>
</div>
</div>
<%if(session.getAttribute("username")==null){%>
<div class="modal fade" onselectstart="return false" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="login_Modal">
    <div class="modal-dialog modal-sm ">
        <div class="modal-content vertical-grabber">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center" name="login_Modal">用户登录</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon" name="sizing-addon4"><span class="glyphicon glyphicon-user"></span></span>
                            <input type="text" autocomplete="on" autofocus id="username_input" placeholder="用户(6-12位,不含中文空格)" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon" name="sizing-addon4"><span class="glyphicon glyphicon-lock"></span></span>
                            <input type="text" id="pwd_input"  placeholder="密码(6-12位,不含中文空格)" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="checkbox">

                        </div>
                    </div>
                    <div class="form-group ">
                        <div class="input-group">
                            <div class="form-control">
                            <label for="inputrember">
                                <input type="checkbox" id="inputrember" > 记住我
                            </label>
                            </div>
                            <span class="text-right input-group-btn">
                            <a type="button" class="form-control" id="forget_btn" style="cursor: pointer; vertical-align: bottom">忘记密码？</a>
                            </span>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button id="login_btn" type="button" class="btn btn-primary btn-lg btn-block center-block">
                    <span class="glyphicon glyphicon-log-in"></span>  确认登录</button>
            </div>
        </div>
    </div>
</div>
<!-- Large modal -->
<div class="modal fade bs-example-modal-lg" onselectstart="return false" tabindex="-1" role="dialog" aria-labelledby="login_Modal">
    <div class="modal-dialog modal-open ">
        <div class="modal-content vertical-grabber">
            <div class="modal-header">
                <button id="reg_close" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center" name="login_Modal">用户注册</h4>
            </div>
            <div class="modal-body">
                <form id="reg_form">
                    <div class="form-group">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon" name="sizing-addon1"><span class="glyphicon glyphicon-user"></span></span>
                            <%--<span class="input-group-addon glyphicon glyphicon-heart" name="sizing-addon1"></span>--%>
                            <input id="reg_userinput" type="text" class="form-control" placeholder="请输入用户名（6-12位不含空格,中文）" aria-describedby="sizing-addon1">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon" name="sizing-addon2"><span class="glyphicon glyphicon-lock"></span></span>
                            <input id="reg_pwdinput" type="password" class="form-control" placeholder="请输入密码（6-12位不含空格）" aria-describedby="sizing-addon2">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon" name="sizing-addon3"><span class="glyphicon glyphicon-lock"></span></span>
                            <input id="reg_pwd2input" type="password" class="form-control" placeholder="请再次输入密码" aria-describedby="sizing-addon3">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon" name="sizing-addon3"><span class="glyphicon glyphicon-envelope"></span></span>
                            <input id="reg_email" type="email" class="form-control" placeholder="请输入电子邮箱（找回密码用到）" aria-describedby="sizing-addon3">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon" name="sizing-addon4"><span class="glyphicon glyphicon-ok"></span></span>
                            <input id="reg_pininput" type="text" class="form-control" placeholder="请输入验证码" aria-describedby="sizing-addon4">
                            <label id="reg_code" style="color: white" class="code input-group-addon" onselectstart="return false"></label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="confirmreg_btn" type="button" class="btn btn-success btn-lg btn-block center-block">确认注册</button>
            </div>
        </div>
    </div>
</div>
<%}%>
<script>
    $(function () {
        $('#choosed_subject').hover(function() {$(this).children('ul').slideDown('normal');$('#subjectstag').addClass('tigger1');},
                 function () {
                    $(this).children('ul').slideUp('normal');$('#subjectstag').removeClass('tigger1')
                });

//        $(window).on('resize',function(){
//            if($(document).width()<1200) {
//                $('[role=sendMsg]').show();
//                if($("#phone-btn").css("display")!='none') {
//                    $("[name=forteacher]").show()
//                }
//                else {
//                    $("[name=forteacher]").hide()
//                }
//            }
//            else {
//                $('[role=sendMsg]').hide();
//                $("[name=forteacher]").show()
//            }
//        })
//        $(window).resize();
    })

    $(document).keydown(function(e){
        if(e.keyCode==13) {
            if($("#loginModal").isShow())
                $("#login_btn").click()
            else if($("#confirmreg_btn").isShow())
                $("#confirmreg_btn").click()
        }
    })
</script>
<script>window.axTag="login";</script>
