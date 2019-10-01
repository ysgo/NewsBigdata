<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>뉴스 검색 및 분석</title>

<script type="text/javascript">
        var _contextPath = "";

        var _sessionUserId = "";
        if (_sessionUserId != "") {
            if (localStorage.getItem("sessionUserId") == null) {
                localStorage.setItem("sessionUserId", _sessionUserId);
            }
        } else {
            if (localStorage.getItem("sessionUserId") != null) {
                localStorage.removeItem("sessionUserId");
            }
        }
    </script>

       <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        var tracking_id = 'UA-126588540-2';
        
            tracking_id = 'UA-126588540-1';
        
        ga('create', tracking_id, 'auto');
        ga('send', 'pageview');
    </script>
</head>



    <body class="">
<script>
    $(function() {
        $(".theme-btn").click(function(e) {
            e.preventDefault();

            var theme = $(this).data("theme");
            if (theme == "default") {
                $("body").removeClass("dark");
                localStorage.removeItem("theme");
            } else {
                $("body").addClass("dark");
                localStorage.setItem("theme", "dark");
            }
        });
    });

    if (localStorage.getItem("theme")) {
        $("body").addClass(localStorage.getItem("theme"));
    }
</script>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="panel-group news-analysis mt-2" id="news-analysis-accordion" role="tablist" aria-multiselectable="true">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne">
                        <h4 class="panel-title">
                            <a class="collapsed" data-toggle="collapse" data-parent="#news-analysis-accordion" href="#collapse-step-1">
                                	뉴스 검색
                                <span class="total-search-key"></span>
                                <span class="quotation-search-key"></span>
                            </a>
                        </h4>
                    </div>
                    <div id="collapse-step-1" data-parent="#news-analysis-accordion" class="panel-collapse collapse ">
                        <div class="panel-body">
                            <div class="step1-search-form">
  <div class="row search-form-body">
    <input type="hidden" id="is-sub-layout" value="true">

    <input type="hidden" id="search-form-data" name="jsonSearchParam">
    <div class="col-xs-12">
        <input type="hidden" name="index-name" value="news" />
        <input type="hidden" id="networkNodeType" value="">
        <input id="search-analyzer" type="hidden" />
        <input id="search-scope" type="hidden" />
        <input id="mainTodayPersonYn" type="hidden" name="N"/>
        <div class="input-group main-search__form">
            <label for="total-search-key" class="hidden">통합검색어</label>
            <input id="total-search-key" type="text"
                   name="search-keyword" class="form-control main-search__keyword search-key"
                   style="ime-mode:active;"
                   placeholder="기본 검색어를 입력해주세요" autocomplete="off">
			<input type="hidden" id="topicOrigin" value=""/>
            <span class="input-group-btn">
                <button class="btn main-search__search-btn news-search-btn" type="button">
                    <i class="fa fa-search"></i> 검색
                </button>
            </span>
        </div>

        <div id="suggests-wrap">
            <ul class="dropdown-menu suggest-list"></ul>
        </div>

        <div class="main-search-filters text-left mt-2">
            <button class="btn btn-default main-search-filters__btn-init main-search-filter-init" id="search-filter-refresh">
                검색조건 <i class="fa fa-sync"></i>
            </button>

            <div class="dropdown main-search-filters__item " id="date-filter-div">
                <button class="btn btn-sm btn-default main-search-filters__btn dropdown-toggle" id="date-filter-btn" type="button" data-toggle="dropdown">
                    기간
                    <span class="caret"></span>
                </button>
                <div class="dropdown-menu static-dropdown-menu main-search-filters__dropdown">
                    <div>
                        <button type="button" class="btn btn-sm main-search-filters__dropdown__btn half date-select-btn"
                            data-value="1" data-type="day">
                            1일
                        </button>
                        <button type="button" class="btn btn-sm main-search-filters__dropdown__btn half date-select-btn"
                            data-value="1" data-type="week">
                            1주
                        </button>
                        <button type="button" class="btn btn-sm main-search-filters__dropdown__btn half date-select-btn"
                            data-value="1" data-type="month">
                            1개월
                        </button>
                        <button type="button" class="btn btn-sm main-search-filters__dropdown__btn half date-select-btn active"
                            data-value="3" data-type="month">
                            3개월
                        </button>
                        <button type="button" class="btn btn-sm main-search-filters__dropdown__btn half date-select-btn"
                            data-value="6" data-type="month">
                            6개월
                        </button>
                        <button type="button" class="btn btn-sm main-search-filters__dropdown__btn half date-select-btn"
                            data-value="1" data-type="year">
                            1년
                        </button>
                        <button type="button" class="btn btn-sm w-100 main-search-filters__dropdown__btn date-select-btn"
                            data-value="0" data-type="all">
                            전체
                        </button>
                    </div>
                    <div class="divider"></div>
                    <div>
                        직접입력

                        <div class="datepicker-wrap">
                            <label for="search-begin-date" class="hidden">시작일</label>
                            <input id="search-begin-date" type="text" class="form-control datetimepicker">
                        </div>

                        <div class="datepicker-wrap">
                            <label for="search-end-date" class="hidden">종료일</label>
                            <input id="search-end-date" type="text" class="form-control datetimepicker"
                                value="">
                        </div>
                    </div>
                    <div class="divider"></div>
                    <div class="action-wrap">
                        <button type="button" class="btn btn-sm btn-default clear-filter-btn" data-type="date">삭제</button>
                        <button type="button" class="btn btn-sm btn-primary close-filter-btn" id="date-confirm-btn">적용</button>
                    </div>
                </div>
            </div>

            <div class="dropdown main-search-filters__item none-relative">
                <button class="btn btn-sm btn-default main-search-filters__btn dropdown-toggle" type="button" data-toggle="dropdown" id="provider-filter-btn">
                    언론사 (<span class="selected-provider-cnt">0</span>/<span id="total-provider-cnt">0</span>)
                    <span class="caret"></span>
                </button>
                <div class="dropdown-menu static-dropdown-menu main-search-filters__dropdown">
                    <div id="providers-wrap"></div>
                    <div class="divider"></div>
                    <div class="action-wrap">
                        <button type="button" class="btn btn-sm btn-default half clear-filter-btn" data-type="provider">삭제</button>
                        <button type="button" class="btn btn-sm btn-primary half close-filter-btn">적용</button>
                    </div>
                </div>
            </div>

            <div class="dropdown main-search-filters__item">
                <button class="btn btn-sm btn-default main-search-filters__btn dropdown-toggle" type="button" data-toggle="dropdown" id="category-filter-btn">
                    통합분류 (<span class="selected-category-cnt">0</span>/<span id="total-category-count">0</span>)
                    <span class="caret"></span>
                </button>

                <div class="dropdown-menu static-dropdown-menu main-search-filters__dropdown">
                    <div id="category-tree-wrap" class="main-search-filters__categories-wrap">
                    </div>
                    <div class="divider"></div>
                    <div class="action-wrap">
                        <button type="button" class="btn btn-sm btn-default clear-filter-btn" data-type="category">삭제</button>
                        <button type="button" class="btn btn-sm btn-primary close-filter-btn">적용</button>
                    </div>
                </div>
            </div>

            <div class="dropdown main-search-filters__item">
                <button class="btn btn-sm btn-default main-search-filters__btn dropdown-toggle" type="button" data-toggle="dropdown" id="incident-filter-btn">
                    사건사고 분류 (<span class="selected-incident-cnt">0</span>/<span id="total-incident-count">0</span>)
                    <span class="caret"></span>
                </button>

                <div class="dropdown-menu static-dropdown-menu main-search-filters__dropdown">
                    <div id="incident-tree-wrap" class="main-search-filters__categories-wrap">
                    </div>
                    <div class="divider"></div>
                    <div class="action-wrap">
                        <button type="button" class="btn btn-sm btn-default clear-filter-btn" data-type="incident">삭제</button>
                        <button type="button" class="btn btn-sm btn-primary close-filter-btn">적용</button>
                    </div>
                </div>
            </div>

            <div class="dropdown main-search-filters__item none-relative" id="detail-filter-div">
                <button class="btn btn-sm btn-default main-search-filters__btn dropdown-toggle" type="button" data-toggle="dropdown" id="detail-filter-btn">
                    상세검색
                    <span class="caret"></span>
                </button>

                <div class="dropdown-menu static-dropdown-menu main-search-filters__dropdown">
                    <div class="detail-search-tabs">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="active"><a href="#detail-search-tab-keyword" data-toggle="tab">상세검색</a></li>
                            <li><a href="#detail-search-tab-dict" data-toggle="tab">사전검색</a></li>
                            <li><a id="detail-expression-tab" href="#detail-search-tab-expression" data-toggle="tab">나의검색식 검색</a></li>
                        </ul>
                    </div>

                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="detail-search-tab-keyword">
                            <div class="detail-form-keywords">
                                <div class="primary-text help-block">
                                    <i class="fal fa-exclamation-circle"></i> 상세검색으로 더 정확한 검색 결과를 얻을 수 있습니다. 인용문 검색시 바이그램검색만 가능합니다.
                                </div>
                                <div class="form-group">
                                    <label style="margin-bottom: 0; margin-right: 8px;" for="search-index-type-news">검색 유형</label>

                                    <div class="radio radio-primary radio-inline">
                                        <input type="radio" id="search-index-type-news" value="news" name="search-index-type" checked>
                                        <label for="search-index-type-news"> 뉴스 </label>
                                    </div>

                                    <div class="radio radio-primary radio-inline">
                                        <input type="radio" id="search-index-type-quotation" value="news_quotation" name="search-index-type">
                                        <label for="search-index-type-quotation"> 인용문 </label>
                                    </div>
                                </div>

                                <div class="detail-search-group" data-group="news">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-3">
                                            <div class="form-group">
                                                <label for="search-filter-type">
                                                    검색어 처리
                                                </label>
                                                <div class="select-form-wrap">
                                                    <select id="search-filter-type" class="form-control">
                                                        <option value="1" selected>형태소 분석</option>
                                                        <option value="2">바이그램</option>
                                                        <option value="3">형태소/바이그램 분석</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6 col-sm-3">
                                            <div class="form-group">
                                                <label for="search-scope-type">
                                                    검색어 범위
                                                </label>
                                                <div class="select-form-wrap">
                                                    <select id="search-scope-type" class="form-control">
                                                        <option value="1" selected>제목+본문</option>
                                                        <option value="2">제목</option>
                                                        <option value="3">본문</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-3">
                                            <div class="form-group">
                                                <label for="byline">
                                                    기고자명
                                                </label>
                                                <input id="byline" type="text" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="form-group">
                                            <label for="orKeyword1">단어 중 1개 이상 포함(단어가 여럿일 경우 ','로 분리)</label>
                                            <input id="orKeyword1" type="text" class="form-control detail-keyword keyword-or" data-seq="0">
                                        </div>

                                        <div class="form-group">
                                            <label for="andKeyword1">다음단어 모두 포함</label>
                                            <input id="andKeyword1" type="text" class="form-control detail-keyword keyword-and" data-seq="0">
                                        </div>

                                        <div class="form-group">
                                            <label for="exactKeyword1">정확히 일치하는 단어</label>
                                            <input id="exactKeyword1" type="text" class="form-control detail-keyword keyword-exact" data-seq="0"
                                                   placeholder="검색어 처리를 바이그램으로 선택하시면 더 정확한 결과를 얻을 수 있습니다.">
                                        </div>

                                        <div class="form-group">
                                            <label for="notKeyword1">다음단어 제외</label>
                                            <input id="notKeyword1" type="text" class="form-control detail-keyword keyword-not" data-seq="0">
                                        </div>
                                    </div>
                                </div>

                                <div class="detail-search-group" data-group="news_quotation" style="display: none">
                                    <div class="form-group hidden">
                                        <label for="quotation-keyword1">인용문</label>
                                        <input id="quotation-keyword1" type="text" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="total-search-key-copy">뉴스내인용문</label>
                                        <input id="total-search-key-copy" type="text" class="form-control detail-keyword" placeholder="키워드가 포함된 뉴스의 모든 인용문 추출, 메인 검색창과 동일합니다.">
                                    </div>

                                    <div class="form-group">
                                        <label for="quotation-keyword2">인용문</label>
                                        <input id="quotation-keyword2" type="text" class="form-control detail-keyword quotation-keyword" placeholder="키워드가 포함된 인용문 추출">
                                    </div>

                                    <div class="form-group">
                                        <label for="quotation-keyword3">정보원</label>
                                        <input id="quotation-keyword3" type="text" class="form-control detail-keyword info-source" placeholder="키워드가 포함된 정보원 추출">
                                    </div>
                                </div>

                                <div class="text-center">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-offset-3 col-sm-3">
                                            <button type="button" class="btn btn-default btn-search w-100 detail-clear-btn">
                                                초기화
                                            </button>
                                        </div>
                                        <div class="col-xs-6 col-sm-3">
                                            <button class="btn btn-primary btn-search w-100 news-search-btn">
                                                검색
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane dict-search" id="detail-search-tab-dict">
                            


<div class="dict-detail-wrap" data-type="texanomy">
    <div id="dict-list-wrap" class="dict-search__list">
    </div>
    <div class="dict-basic-option">
        <div class="dict-search__tree">
            <div class="dict-search__loader">
                <div class="dict-search__spinner la-line-spin-fade-rotating la-3x">
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                </div>
            </div>
            <div id="dict-tree-wrap"></div>
        </div>

        <div class="dict-concat-option-wrap dict-search__concat-option">
            <div class="radio radio-primary radio-inline">
                <input type="radio" id="dict-concat-or" value=" OR " name="dict-concat" checked>
                <label for="dict-concat-or"> OR </label>
            </div>

            <div class="radio radio-primary radio-inline">
                <input type="radio" id="dict-concat-and" value=" AND " name="dict-concat">
                <label for="dict-concat-and"> AND </label>
            </div>

            <div class="radio radio-primary radio-inline">
                <input type="radio" id="dict-concat-not" value="NOT" name="dict-concat">
                <label for="dict-concat-not"> NOT </label>
            </div>
        </div>

        <div class="row mt-2">
            <div class="col-xs-6">
                <button type="button" class="btn btn-default cancel-dict-option w-100">
                    초기화
                </button>
            </div>
            <div class="col-xs-6">
                <button type="button" class="btn btn-primary apply-dict-option w-100">
                    선택 적용
                </button>
            </div>
        </div>
    </div>
</div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="detail-search-tab-expression">
                            


<div class="detail-form-keywords">
    <div class="primary-text help-block">
        <i class="fal fa-exclamation-circle"></i> 직접 구성하여 저장된 나의 검색식을 활용해 검색합니다.
    </div>

    <div class="form-group">
        <div id="expression-list-wrap">

        </div>
    </div>

    <div class="form-group">
        <div id="expression-detail-wrap">
        </div>
    </div>

    <div class="form-group">
        <div class="text-center">
            <div class="row">
                <div class="col-xs-6 col-xs-offset-3 col-sm-offset-4 col-sm-4">
                    <button type="button" class="btn btn-primary w-100 expression-search-btn">
                        검색식으로 검색
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
                        </div>
                    </div>
                </div>
            </div>

            <button class="btn btn-default main-search-filters__btn-init pull-right" data-type="search-helper-show">
                <i class="fal fa-info-circle"></i> 검색도움말
            </button>
        </div>
    </div>
</div>



                                
                                <form id="news-search-form" action="/v2/news/search.do" method="post">
                                    <input type="hidden" id="news-search-form-data" name="jsonSearchParam">
                                    <input type="hidden" id="init-date-codes">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingTwo">
                        <h4 class="panel-title">
                            <a class="collapsed" data-toggle="collapse" data-parent="#news-analysis-accordion" href="#collapse-step-2">
                                Step 02. 검색 결과
                            </a>
                        </h4>
                    </div>
                    <div id="collapse-step-2" data-parent="#news-analysis-accordion" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <div class="row">
                                <!-- 검색 결과 필터 시작 -->
                                <div class="col-sm-3 col-lg-2">
                                    <div class="news-filter">
                                        <h4>
                                            검색 필터

                                            <button class="btn btn-link btn-xs news-filter__refresh-btn refresh-result-filter-btn">
                                                <i class="fas fa-sync"></i>
                                            </button>
                                        </h4>

                                        <div id="filter-affix" data-spy="affix" data-offset-top="200" class="hidden">
                                            <button class="btn btn-primary w-100">
                                                필터 적용
                                            </button>
                                        </div>

                                        <div class="news-filter__item">
                                            <div class="panel">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#" href="#filter-date">
                                                            기간
                                                        </a>
                                                    </h4>
                                                </div>

                                                <div id="filter-date" class="panel-collapse collapse in">
                                                    <div class="panel-body">
                                                        <div id="date-filter-wrap"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="news-filter__item">
                                            <div class="panel">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#" href="#filter-provier">
                                                            언론사
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="filter-provier" class="panel-collapse collapse in">
                                                    <div class="panel-body">
                                                        
                                                        
                                                            
                                                                
                                                                    <h5 class="">
                                                                            중앙지
                                                                    </h5>
                                                                

                                                                <div class="news-filter__provider-item clearfix ">
                                                                    <label for="filter-provider-01100101" class="news-filter__provider-label">
                                                                            경향신문
                                                                        <span class="provider-cnt" data-code="01100101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100101" data-type="provider">
                                                                        <label for="filter-provider-01100101">
                                                                            <span class="hidden">01100101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix ">
                                                                    <label for="filter-provider-01100201" class="news-filter__provider-label">
                                                                            국민일보
                                                                        <span class="provider-cnt" data-code="01100201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100201" data-type="provider">
                                                                        <label for="filter-provider-01100201">
                                                                            <span class="hidden">01100201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix ">
                                                                    <label for="filter-provider-01100301" class="news-filter__provider-label">
                                                                            내일신문
                                                                        <span class="provider-cnt" data-code="01100301">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100301" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100301" data-type="provider">
                                                                        <label for="filter-provider-01100301">
                                                                            <span class="hidden">01100301</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix ">
                                                                    <label for="filter-provider-01100401" class="news-filter__provider-label">
                                                                            동아일보
                                                                        <span class="provider-cnt" data-code="01100401">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100401" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100401" data-type="provider">
                                                                        <label for="filter-provider-01100401">
                                                                            <span class="hidden">01100401</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix ">
                                                                    <label for="filter-provider-01100501" class="news-filter__provider-label">
                                                                            문화일보
                                                                        <span class="provider-cnt" data-code="01100501">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100501" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100501" data-type="provider">
                                                                        <label for="filter-provider-01100501">
                                                                            <span class="hidden">01100501</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01100611" class="news-filter__provider-label">
                                                                            서울신문
                                                                        <span class="provider-cnt" data-code="01100611">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100611" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100611" data-type="provider">
                                                                        <label for="filter-provider-01100611">
                                                                            <span class="hidden">01100611</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01100701" class="news-filter__provider-label">
                                                                            세계일보
                                                                        <span class="provider-cnt" data-code="01100701">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100701" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100701" data-type="provider">
                                                                        <label for="filter-provider-01100701">
                                                                            <span class="hidden">01100701</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01100801" class="news-filter__provider-label">
                                                                            조선일보
                                                                        <span class="provider-cnt" data-code="01100801">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100801" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100801" data-type="provider">
                                                                        <label for="filter-provider-01100801">
                                                                            <span class="hidden">01100801</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01100901" class="news-filter__provider-label">
                                                                            중앙일보
                                                                        <span class="provider-cnt" data-code="01100901">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01100901" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01100901" data-type="provider">
                                                                        <label for="filter-provider-01100901">
                                                                            <span class="hidden">01100901</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01101001" class="news-filter__provider-label">
                                                                            한겨레
                                                                        <span class="provider-cnt" data-code="01101001">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01101001" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01101001" data-type="provider">
                                                                        <label for="filter-provider-01101001">
                                                                            <span class="hidden">01101001</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01101101" class="news-filter__provider-label">
                                                                            한국일보
                                                                        <span class="provider-cnt" data-code="01101101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01101101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01101101" data-type="provider">
                                                                        <label for="filter-provider-01101101">
                                                                            <span class="hidden">01101101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                        
                                                            
                                                                
                                                                    <h5 class="collapsed-provider hidden">
                                                                            경제지
                                                                    </h5>
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100101" class="news-filter__provider-label">
                                                                            매일경제
                                                                        <span class="provider-cnt" data-code="02100101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100101" data-type="provider">
                                                                        <label for="filter-provider-02100101">
                                                                            <span class="hidden">02100101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100201" class="news-filter__provider-label">
                                                                            머니투데이
                                                                        <span class="provider-cnt" data-code="02100201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100201" data-type="provider">
                                                                        <label for="filter-provider-02100201">
                                                                            <span class="hidden">02100201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100311" class="news-filter__provider-label">
                                                                            서울경제
                                                                        <span class="provider-cnt" data-code="02100311">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100311" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100311" data-type="provider">
                                                                        <label for="filter-provider-02100311">
                                                                            <span class="hidden">02100311</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100801" class="news-filter__provider-label">
                                                                            아시아경제
                                                                        <span class="provider-cnt" data-code="02100801">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100801" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100801" data-type="provider">
                                                                        <label for="filter-provider-02100801">
                                                                            <span class="hidden">02100801</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100851" class="news-filter__provider-label">
                                                                            아주경제
                                                                        <span class="provider-cnt" data-code="02100851">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100851" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100851" data-type="provider">
                                                                        <label for="filter-provider-02100851">
                                                                            <span class="hidden">02100851</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100501" class="news-filter__provider-label">
                                                                            파이낸셜뉴스
                                                                        <span class="provider-cnt" data-code="02100501">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100501" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100501" data-type="provider">
                                                                        <label for="filter-provider-02100501">
                                                                            <span class="hidden">02100501</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100601" class="news-filter__provider-label">
                                                                            한국경제
                                                                        <span class="provider-cnt" data-code="02100601">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100601" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100601" data-type="provider">
                                                                        <label for="filter-provider-02100601">
                                                                            <span class="hidden">02100601</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-02100701" class="news-filter__provider-label">
                                                                            헤럴드경제
                                                                        <span class="provider-cnt" data-code="02100701">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-02100701" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="02100701" data-type="provider">
                                                                        <label for="filter-provider-02100701">
                                                                            <span class="hidden">02100701</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                        
                                                            
                                                                
                                                                    <h5 class="collapsed-provider hidden">
                                                                            지역종합지
                                                                    </h5>
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01300101" class="news-filter__provider-label">
                                                                            강원도민일보
                                                                        <span class="provider-cnt" data-code="01300101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01300101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01300101" data-type="provider">
                                                                        <label for="filter-provider-01300101">
                                                                            <span class="hidden">01300101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01300201" class="news-filter__provider-label">
                                                                            강원일보
                                                                        <span class="provider-cnt" data-code="01300201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01300201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01300201" data-type="provider">
                                                                        <label for="filter-provider-01300201">
                                                                            <span class="hidden">01300201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01200101" class="news-filter__provider-label">
                                                                            경기일보
                                                                        <span class="provider-cnt" data-code="01200101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01200101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01200101" data-type="provider">
                                                                        <label for="filter-provider-01200101">
                                                                            <span class="hidden">01200101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500151" class="news-filter__provider-label">
                                                                            경남도민일보
                                                                        <span class="provider-cnt" data-code="01500151">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500151" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500151" data-type="provider">
                                                                        <label for="filter-provider-01500151">
                                                                            <span class="hidden">01500151</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500051" class="news-filter__provider-label">
                                                                            경남신문
                                                                        <span class="provider-cnt" data-code="01500051">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500051" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500051" data-type="provider">
                                                                        <label for="filter-provider-01500051">
                                                                            <span class="hidden">01500051</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500301" class="news-filter__provider-label">
                                                                            경상일보
                                                                        <span class="provider-cnt" data-code="01500301">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500301" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500301" data-type="provider">
                                                                        <label for="filter-provider-01500301">
                                                                            <span class="hidden">01500301</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01200201" class="news-filter__provider-label">
                                                                            경인일보
                                                                        <span class="provider-cnt" data-code="01200201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01200201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01200201" data-type="provider">
                                                                        <label for="filter-provider-01200201">
                                                                            <span class="hidden">01200201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01600201" class="news-filter__provider-label">
                                                                            광주매일신문
                                                                        <span class="provider-cnt" data-code="01600201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01600201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01600201" data-type="provider">
                                                                        <label for="filter-provider-01600201">
                                                                            <span class="hidden">01600201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01600301" class="news-filter__provider-label">
                                                                            광주일보
                                                                        <span class="provider-cnt" data-code="01600301">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01600301" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01600301" data-type="provider">
                                                                        <label for="filter-provider-01600301">
                                                                            <span class="hidden">01600301</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500401" class="news-filter__provider-label">
                                                                            국제신문
                                                                        <span class="provider-cnt" data-code="01500401">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500401" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500401" data-type="provider">
                                                                        <label for="filter-provider-01500401">
                                                                            <span class="hidden">01500401</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500501" class="news-filter__provider-label">
                                                                            대구일보
                                                                        <span class="provider-cnt" data-code="01500501">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500501" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500501" data-type="provider">
                                                                        <label for="filter-provider-01500501">
                                                                            <span class="hidden">01500501</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01400201" class="news-filter__provider-label">
                                                                            대전일보
                                                                        <span class="provider-cnt" data-code="01400201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01400201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01400201" data-type="provider">
                                                                        <label for="filter-provider-01400201">
                                                                            <span class="hidden">01400201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500601" class="news-filter__provider-label">
                                                                            매일신문
                                                                        <span class="provider-cnt" data-code="01500601">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500601" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500601" data-type="provider">
                                                                        <label for="filter-provider-01500601">
                                                                            <span class="hidden">01500601</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01600501" class="news-filter__provider-label">
                                                                            무등일보
                                                                        <span class="provider-cnt" data-code="01600501">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01600501" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01600501" data-type="provider">
                                                                        <label for="filter-provider-01600501">
                                                                            <span class="hidden">01600501</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500701" class="news-filter__provider-label">
                                                                            부산일보
                                                                        <span class="provider-cnt" data-code="01500701">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500701" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500701" data-type="provider">
                                                                        <label for="filter-provider-01500701">
                                                                            <span class="hidden">01500701</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500801" class="news-filter__provider-label">
                                                                            영남일보
                                                                        <span class="provider-cnt" data-code="01500801">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500801" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500801" data-type="provider">
                                                                        <label for="filter-provider-01500801">
                                                                            <span class="hidden">01500801</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01500901" class="news-filter__provider-label">
                                                                            울산매일
                                                                        <span class="provider-cnt" data-code="01500901">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01500901" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01500901" data-type="provider">
                                                                        <label for="filter-provider-01500901">
                                                                            <span class="hidden">01500901</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01600801" class="news-filter__provider-label">
                                                                            전남일보
                                                                        <span class="provider-cnt" data-code="01600801">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01600801" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01600801" data-type="provider">
                                                                        <label for="filter-provider-01600801">
                                                                            <span class="hidden">01600801</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01601001" class="news-filter__provider-label">
                                                                            전북도민일보
                                                                        <span class="provider-cnt" data-code="01601001">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01601001" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01601001" data-type="provider">
                                                                        <label for="filter-provider-01601001">
                                                                            <span class="hidden">01601001</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01601101" class="news-filter__provider-label">
                                                                            전북일보
                                                                        <span class="provider-cnt" data-code="01601101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01601101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01601101" data-type="provider">
                                                                        <label for="filter-provider-01601101">
                                                                            <span class="hidden">01601101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01700101" class="news-filter__provider-label">
                                                                            제민일보
                                                                        <span class="provider-cnt" data-code="01700101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01700101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01700101" data-type="provider">
                                                                        <label for="filter-provider-01700101">
                                                                            <span class="hidden">01700101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01400351" class="news-filter__provider-label">
                                                                            중도일보
                                                                        <span class="provider-cnt" data-code="01400351">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01400351" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01400351" data-type="provider">
                                                                        <label for="filter-provider-01400351">
                                                                            <span class="hidden">01400351</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01400401" class="news-filter__provider-label">
                                                                            중부매일
                                                                        <span class="provider-cnt" data-code="01400401">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01400401" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01400401" data-type="provider">
                                                                        <label for="filter-provider-01400401">
                                                                            <span class="hidden">01400401</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01400501" class="news-filter__provider-label">
                                                                            중부일보
                                                                        <span class="provider-cnt" data-code="01400501">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01400501" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01400501" data-type="provider">
                                                                        <label for="filter-provider-01400501">
                                                                            <span class="hidden">01400501</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01400551" class="news-filter__provider-label">
                                                                            충북일보
                                                                        <span class="provider-cnt" data-code="01400551">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01400551" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01400551" data-type="provider">
                                                                        <label for="filter-provider-01400551">
                                                                            <span class="hidden">01400551</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01400601" class="news-filter__provider-label">
                                                                            충청일보
                                                                        <span class="provider-cnt" data-code="01400601">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01400601" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01400601" data-type="provider">
                                                                        <label for="filter-provider-01400601">
                                                                            <span class="hidden">01400601</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01400701" class="news-filter__provider-label">
                                                                            충청투데이
                                                                        <span class="provider-cnt" data-code="01400701">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01400701" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01400701" data-type="provider">
                                                                        <label for="filter-provider-01400701">
                                                                            <span class="hidden">01400701</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-01700201" class="news-filter__provider-label">
                                                                            한라일보
                                                                        <span class="provider-cnt" data-code="01700201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-01700201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="01700201" data-type="provider">
                                                                        <label for="filter-provider-01700201">
                                                                            <span class="hidden">01700201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                        
                                                            
                                                                
                                                                    <h5 class="collapsed-provider hidden">
                                                                            방송사
                                                                    </h5>
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-08100101" class="news-filter__provider-label">
                                                                            KBS
                                                                        <span class="provider-cnt" data-code="08100101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-08100101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="08100101" data-type="provider">
                                                                        <label for="filter-provider-08100101">
                                                                            <span class="hidden">08100101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-08100201" class="news-filter__provider-label">
                                                                            MBC
                                                                        <span class="provider-cnt" data-code="08100201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-08100201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="08100201" data-type="provider">
                                                                        <label for="filter-provider-08100201">
                                                                            <span class="hidden">08100201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-08200101" class="news-filter__provider-label">
                                                                            OBS
                                                                        <span class="provider-cnt" data-code="08200101">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-08200101" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="08200101" data-type="provider">
                                                                        <label for="filter-provider-08200101">
                                                                            <span class="hidden">08200101</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-08100301" class="news-filter__provider-label">
                                                                            SBS
                                                                        <span class="provider-cnt" data-code="08100301">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-08100301" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="08100301" data-type="provider">
                                                                        <label for="filter-provider-08100301">
                                                                            <span class="hidden">08100301</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-08100401" class="news-filter__provider-label">
                                                                            YTN
                                                                        <span class="provider-cnt" data-code="08100401">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-08100401" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="08100401" data-type="provider">
                                                                        <label for="filter-provider-08100401">
                                                                            <span class="hidden">08100401</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                        
                                                            
                                                                
                                                                    <h5 class="collapsed-provider hidden">
                                                                            전문지
                                                                    </h5>
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-07101201" class="news-filter__provider-label">
                                                                            디지털타임스
                                                                        <span class="provider-cnt" data-code="07101201">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-07101201" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="07101201" data-type="provider">
                                                                        <label for="filter-provider-07101201">
                                                                            <span class="hidden">07101201</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                                

                                                                <div class="news-filter__provider-item clearfix collapsed-provider hidden">
                                                                    <label for="filter-provider-07100501" class="news-filter__provider-label">
                                                                            전자신문
                                                                        <span class="provider-cnt" data-code="07100501">(0)</span>
                                                                    </label>

                                                                    <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                         data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                        <input id="filter-provider-07100501" class="styled filter-provider filter-input"
                                                                               type="checkbox" value="07100501" data-type="provider">
                                                                        <label for="filter-provider-07100501">
                                                                            <span class="hidden">07100501</span>
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                
                                                            
                                                        

                                                        <div class="toggle-provider text-center">
                                                            <button class="btn btn-default provider-unfold-btn btn-sm">
                                                                펼치기
                                                            </button>
                                                            <button class="btn btn-default provider-fold-btn btn-sm">
                                                                접기
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="news-filter__item">
                                            <div class="panel">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#" href="#filter-category">
                                                            통합분류
                                                        </a>
                                                    </h4>
                                                </div>
                                            </div>

                                            <div id="filter-category" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-001000000" class="news-filter__category-label">
                                                                    정치
                                                                <span class="category-cnt" data-code="001000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-001000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="001000000" data-type="category">
                                                                <label for="filter-category-001000000">
                                                                    <span class="hidden">001000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-002000000" class="news-filter__category-label">
                                                                    경제
                                                                <span class="category-cnt" data-code="002000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-002000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="002000000" data-type="category">
                                                                <label for="filter-category-002000000">
                                                                    <span class="hidden">002000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-003000000" class="news-filter__category-label">
                                                                    사회
                                                                <span class="category-cnt" data-code="003000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-003000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="003000000" data-type="category">
                                                                <label for="filter-category-003000000">
                                                                    <span class="hidden">003000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-004000000" class="news-filter__category-label">
                                                                    문화
                                                                <span class="category-cnt" data-code="004000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-004000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="004000000" data-type="category">
                                                                <label for="filter-category-004000000">
                                                                    <span class="hidden">004000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-005000000" class="news-filter__category-label">
                                                                    국제
                                                                <span class="category-cnt" data-code="005000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-005000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="005000000" data-type="category">
                                                                <label for="filter-category-005000000">
                                                                    <span class="hidden">005000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-006000000" class="news-filter__category-label">
                                                                    지역
                                                                <span class="category-cnt" data-code="006000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-006000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="006000000" data-type="category">
                                                                <label for="filter-category-006000000">
                                                                    <span class="hidden">006000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-007000000" class="news-filter__category-label">
                                                                    스포츠
                                                                <span class="category-cnt" data-code="007000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-007000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="007000000" data-type="category">
                                                                <label for="filter-category-007000000">
                                                                    <span class="hidden">007000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__category-item clearfix">
                                                            <label for="filter-category-008000000" class="news-filter__category-label">
                                                                    IT_과학
                                                                <span class="category-cnt" data-code="008000000">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-category-008000000" class="styled filter-category filter-input"
                                                                       type="checkbox" value="008000000" data-type="category">
                                                                <label for="filter-category-008000000">
                                                                    <span class="hidden">008000000</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                </div>
                                            </div>
                                        </div>

                                        <div class="news-filter__item">
                                            <div class="panel">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#" href="#filter-incident">
                                                            사건사고 분류
                                                        </a>
                                                    </h4>
                                                </div>
                                            </div>

                                            <div id="filter-incident" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    
                                                        <div class="news-filter__incident-item clearfix">
                                                            <label for="filter-incident-1" class="news-filter__incident-label">
                                                                    범죄
                                                                <span class="incident-cnt" data-sn="1">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-incident-1" class="styled filter-incident filter-input"
                                                                       type="checkbox" value="1,5,16,15,14,18,17,7,24,8,30,27,29,26,25,31,28,6,22,23,21,19,20"
                                                                       data-type="incident"
                                                                       data-sn="1">
                                                                <label for="filter-incident-1">
                                                                    <span class="hidden">1</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__incident-item clearfix">
                                                            <label for="filter-incident-2" class="news-filter__incident-label">
                                                                    사고
                                                                <span class="incident-cnt" data-sn="2">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-incident-2" class="styled filter-incident filter-input"
                                                                       type="checkbox" value="2,10,38,37,36,40,39,9,34,33,35,32"
                                                                       data-type="incident"
                                                                       data-sn="2">
                                                                <label for="filter-incident-2">
                                                                    <span class="hidden">2</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__incident-item clearfix">
                                                            <label for="filter-incident-3" class="news-filter__incident-label">
                                                                    재해
                                                                <span class="incident-cnt" data-sn="3">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-incident-3" class="styled filter-incident filter-input"
                                                                       type="checkbox" value="3,11,44,43,48,42,46,47,41,45"
                                                                       data-type="incident"
                                                                       data-sn="3">
                                                                <label for="filter-incident-3">
                                                                    <span class="hidden">3</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                        <div class="news-filter__incident-item clearfix">
                                                            <label for="filter-incident-4" class="news-filter__incident-label">
                                                                    사회
                                                                <span class="incident-cnt" data-sn="4">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-incident-4" class="styled filter-incident filter-input"
                                                                       type="checkbox" value="4,13,54,56,58,55,57,12,53,52,49,51,50"
                                                                       data-type="incident"
                                                                       data-sn="4">
                                                                <label for="filter-incident-4">
                                                                    <span class="hidden">4</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    
                                                </div>
                                            </div>
                                        </div>

                                        <div class="news-filter__item">
                                            <div class="panel">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#" href="#filter-tm-use-yn">
                                                            분석
                                                            <small class="tooltip-icon"
                                                                   data-toggle="tooltip" data-placement="top"
                                                                   title="필터를 적용하여 분석 제외(중복·예외) 기사를 확인할 수 있습니다.
                                                                   (중복: 반복되는 유사도 높은 기사, 예외: 인사, 부고, 동정, 포토 등의 내용을 담은 기사)">
                                                                <i class="far fa-question-circle"></i>
                                                            </small>
                                                        </a>
                                                    </h4>
                                                </div>

                                                <div id="filter-tm-use-yn" class="panel-collapse collapse in">
                                                    <div class="panel-body">
                                                        <div class="news-filter__incident-item clearfix">
                                                            <label for="filter-tm-use" class="news-filter__incident-label">
                                                                분석 기사
                                                                <span class="tm-use-cnt">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-tm-use" class="styled filter-tm-use filter-input" type="checkbox"
                                                                       data-type="tm-use" value="">
                                                                <label for="filter-tm-use"></label>
                                                            </div>
                                                        </div>

                                                        <div class="news-filter__incident-item clearfix">
                                                            <label for="filter-not-tm-use" class="news-filter__incident-label">
                                                                분석 제외
                                                                <span class="not-tm-use-cnt">(0)</span>
                                                            </label>

                                                            <div class="checkbox checkbox-inline checkbox-primary pull-right filter-tooltip"
                                                                 data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <input id="filter-not-tm-use" class="styled filter-not-tm-use filter-input" type="checkbox"
                                                                       data-type="not-tm-use">
                                                                <label for="filter-not-tm-use"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 검색 결과 필터 종료 -->

                                <div class="col-sm-9 col-lg-10">
                                    <h4>검색 결과</h4>

                                    <div class="row">
                                        <div class="col-xs-12 col-lg-8 col-sm-8">
                                            <ul class="nav nav-tabs news-analysis__target-tabs mb-1" role="tablist">
                                                <li class="active">
                                                    <a href="#news-results-tab" class="analysis-target-tab" data-toggle="tab"
                                                       data-index="news" data-target="#news-results-tab">
                                                        뉴스
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#quotation-results-tab" class="analysis-target-tab" data-toggle="tab"
                                                       data-index="news_quotation" data-target="#quotation-results-tab">
                                                        인용문
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-xs-12 col-lg-4 col-sm-4 text-right">
                                            <div class="dropdown main-search-filters__item" id="rescan-filter-div">
                                                <button type="button" class="btn btn-default dropdown-toggle select-form-wrap pr-4" data-toggle="dropdown">
                                                    결과 내 재검색

                                                </button>
                                                <div class="dropdown-menu static-dropdown-menu dropdown-menu-right main-search-filters__dropdown">
                                                    <div class="main-search-filters__rescan-wrap">
                                                        <div>
                                                            키워드 포함
                                                            <div class="mb-1 filter-tooltip"
                                                                       data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <label for="rescan-keyword" class="hidden">결과 내 재검색 키워드</label>
                                                                <input id="rescan-keyword" type="text" class="form-control rescan-input">
                                                            </div>
                                                        </div>
                                                        <div>
                                                            키워드 제외
                                                            <div class="mb-1 filter-tooltip"
                                                                       data-toggle="tooltip" data-placement="top" title="오늘의 이슈에서는 제공되지 않습니다.">
                                                                <label for="rescan-except-keyword" class="hidden">결과 내 재검색 키워드</label>
                                                                <input id="rescan-except-keyword" type="text" class="form-control rescan-input">
                                                            </div>
                                                        </div>
                                                        <div class="small mt-2 mb-2">
                                                            <p>* 기본검색의 결과 범위를 줄이고자 할 때 사용합니다.</p>
                                                            <p>* '기본검색어'가 없는 경우 결과 내 재검색에서 '키워드 제외' 기능은 사용이 불가능합니다.</p>
                                                            <p>* 단어가 여럿일 경우 ','로 분리하여 입력바랍니다.</p>
                                                            <p>* 이 외에 추가 조건 검색은 <span class="primary-text">Step01.뉴스검색</span>에서 가능합니다.</p>
                                                        </div>
                                                        <div class="divider"></div>
                                                        <div class="action-wrap">
                                                            <button type="button" class="btn btn-sm btn-default clear-filter-btn" data-type="rescan">삭제</button>
                                                            <button type="button" class="btn btn-sm btn-primary" id="rescan-btn">검색</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="row">
                                            <div class="col-xs-12 col-lg-8 col-sm-5">
                                                <div>
                                                    <i class="fal fa-check-circle"></i>
                                                    <span class="total-search-key-wrap" style="display: none">
                                                        "<span class="total-search-key"></span>"
                                                    </span>

                                                    <span class="search-info-sub-desc search-info-quotation-desc" data-index="news_quotation" style="display: none;">
                                                        이(가) 포함된 뉴스
                                                        <span class="search-info-quotation-at" style="display: none;">에서</span>
                                                        <span class="search-info-quotation-of" style="display: none;">의 모든</span>
                                                    </span>
                                                    <span class="search-info-detail-desc" data-index="quotation" style="display: none;">
                                                        '<span class="primary-text quotation-keyword2"></span>'(이)가 포함된
                                                        <span class="quotation-keyword2-sub" style="display: none;">인용문</span>
                                                    </span>
                                                    <span class="search-info-detail-desc" data-index="speaker" style="display: none;">
                                                        정보원이 '<span class="primary-text quotation-keyword3"></span>'인
                                                    </span>

                                                    <span class="search-info-sub-desc" data-index="news" style="display: none;">
                                                        에 대한 뉴스 검색 결과
                                                    </span>

                                                    <span class="search-info-sub-desc" data-index="news_quotation" style="display: none;">
                                                        인용문 추출결과
                                                    </span>
                                                    <span id="total-news-cnt"></span> 건입니다.
                                                </div>
                                                <div class="black-text">
                                                    <i class="fal fa-calendar-alt"></i>
                                                    <span class="start-date-key"></span> ~ <span class="end-date-key"></span> 기준
                                                </div>
                                            </div>

                                            <div class="col-xs-12 col-lg-4 col-sm-7 text-right">
                                                <div class="select-form-wrap" style="display: inline-block">
                                                    <select class="form-control result-filter sort">
                                                        <option value="date">최신순</option>
                                                        <option value="score">정확도순</option>
                                                        <option value="past">과거순</option>
                                                    </select>
                                                </div>

                                                <div class="select-form-wrap" style="display: inline-block">
                                                    <select class="form-control result-filter per-page">
                                                        
                                                        
                                                            <option value="10">10건씩 보기</option>
                                                        
                                                            <option value="30">30건씩 보기</option>
                                                        
                                                            <option value="50">50건씩 보기</option>
                                                        
                                                            <option value="100">100건씩 보기</option>
                                                        
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-xs-12">
                                                <div id="cs-keywords-wrap"></div>
                                            </div>
                                        </div>
                                    </div>

                                    

<div>
    <h4>데이터 다운로드</h4>
    <p class="news-viz__desc viz-trend__desc">
        검색한 뉴스의 메타데이터(언론사, 기고자, 제목 등)와 개체명(인물, 기관, 장소 등) 분석 데이터를 엑셀파일로 제공하는 서비스입니다.
        <br/>데이터 다운로드는 최대 20,000건의 데이터가 다운로드 됩니다. 미리보기는 최대 20개까지 보여집니다.
    </p>

    <div class="viz-preivew analysis-viz-loader-wrap">
        <div class="analysis-viz-loader">
            <div class="spinner la-line-spin-fade-rotating la-3x">
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>

        <div id="preview-wrap" class="table-responsive"></div>
    </div>

    <div class="text-right mt-2">
        <button class="btn btn-success news-download-btn">
            <i class="fal fa-file-excel"></i> 다운로드
        </button>
    </div>
</div>

                </div>
                <div class="tab-pane" id="analytics-network">
                    


<div>
    <h4 class="news-viz__title viz-trend__title">
        관계도 분석
    </h4>
    <p class="news-viz__desc viz-trend__desc">
	관계도 분석
	   <button type="button" class="btn btn-point btn-xs ml-1" data-toggle="modal" data-target="#exportGuideModal">개체명 추출 방식 안내</button>
    </p>
</div>

<div class="analytics-network-options">
    <div>
        <button type="button" class="btn btn-default hidden-xs analysis-network-view-mode-btn" data-view="kb-detail">
            상세정보
        </button>
        <button type="button" class="btn btn-default hidden-xs analysis-network-view-mode-btn" data-view="related-news">
            관련뉴스
        </button>
    </div>
</div>





<div class="viz-rel-keywords">
    <div>
        <h4 class="news-viz__title viz-trend__title">
            연관어 분석
        </h4>
        <p class="news-viz__desc viz-trend__desc">
            검색 결과 중 분석 뉴스와 연관성(가중치, 키워드 빈도수)이 높은 키워드를 시각화하여 보여주는 서비스입니다.
        </p>
    </div>

    <div class="row">
        <div class="col-xs-12 mb-1">
            <div class="viz-trend__label">
                <i class="fal fa-newspaper"></i> 분석 뉴스 건수
            </div>

            <div class="viz-trend__btns">
                <button type="button" class="btn btn-default btn-sm viz-trend__btn keyword-cnt need-unauth" data-cnt="30">
                    30
                </button>
                <button type="button" class="btn btn-default btn-sm viz-trend__btn keyword-cnt need-unauth" data-cnt="50">
                    50
                </button>
                <button type="button" class="selected btn btn-default btn-sm viz-trend__btn keyword-cnt" data-cnt="100">
                    100
                </button>
                <button type="button" class="btn btn-default btn-sm viz-trend__btn keyword-cnt" data-cnt="300">
                    300
                </button>
                <button type="button" class="btn btn-default btn-sm viz-trend__btn keyword-cnt" data-cnt="500">
                    500
                </button>
                <button type="button" class="btn btn-default btn-sm viz-trend__btn keyword-cnt need-auth" data-cnt="800"
                    style="display: none">
                    800
                </button>
                <button type="button" class="btn btn-default btn-sm viz-trend__btn keyword-cnt need-auth" data-cnt="1000"
                    style="display: none">
                    1,000
                </button>
            </div>
        </div>

        <div class="col-xs-12 mb-1">
            <div class="viz-trend__label">
                <i class="fal fa-calendar-check"></i> 차트 선택
            </div>

            <div class="viz-trend__btns">
                <button type="button" class="selected btn btn-default btn-sm viz-trend__btn keyword-chart-type" data-type="cloud"
                        data-toggle="tooltip" data-placement="bottom" title="버튼 클릭 시 워드클라우드가 재배열됩니다.">
                    <i class="far fa-cloud"></i> 워드클라우드
                </button>
                <button type="button" class="btn btn-default btn-sm viz-trend__btn keyword-chart-type" data-type="line">
                    <i class="far fa-chart-bar"></i> 막대그래프
                </button>
            </div>
        </div>

        <div class="col-xs-12 mb-1">
            <div class="viz-trend__label">
                <i class="fal fa-table"></i> 데이터 유형
            </div>

            <div class="viz-trend__btns">
                <button type="button" class="selected btn btn-default btn-sm viz-trend__btn keyword-target mr-1"
                        data-target="weight" data-toggle="tooltip" data-placement="bottom" title="분석 뉴스 내에서 의미적 유사도가 높은 키워드 순(토픽랭크 알고리즘 기준)">
                    가중치
                </button>
                <a href="#" data-toggle="modal" data-target="#topicrank-modal">
                    <i class="fal fa-question-circle"></i>
                </a>

                <button type="button" class="ml-2 btn btn-default btn-sm viz-trend__btn keyword-target"
                        data-target="tf"
                        data-toggle="tooltip" data-placement="bottom" title="가중치 순으로 선정된 연관어를 해당 연관어가 등장한 횟수 기준으로 재정렬">
                    키워드 빈도수
                </button>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <div class="viz-rel-keywords__chart-wrap">
                <div class="viz-rel-keywords__loader">
                    <div class="viz-rel-keywords__spinner la-line-spin-fade-rotating la-3x">
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                </div>

                <div id="relational-word-chart" style="height: 520px;"></div>
                <div id="wordcloud-download-btn-wrap" class="text-right mb-2">
                    <button class="btn btn-primary save-rel-word-wordcloud-btn">
                        <i class="far fa-cloud"></i> 워드클라우드 다운로드
                    </button>
                </div>
            </div>
        </div>

        <div class="col-xs-12">
            <div id="relational-table-wrap" class="mb-2"></div>

            <div class="text-right">
                <button class="btn btn-success save-rel-word-modal-btn">
                    <i class="fal fa-save"></i> 분석 결과 저장
                </button>

                <button class="btn btn-success relational-word-download-btn">
                    <i class="fal fa-file-excel"></i> 다운로드
                </button>
            </div>
        </div>
    </div>
</div>





<script src="/js/ptech/search/search.js?timestamp=201908061440"></script>
<script src="/js/ptech/search/detailSearch.js?timestamp=201908061440"></script>
<script src="/js/ptech/search/dictSearch.js?timestamp=201908061440"></script>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.7.13.min.js"></script>
<script src="/js/ptech/news/news-detail.js?timestamp=201908061440"></script>
<script src="/js/ptech/news/news-speecher.js?timestamp=201908061440"></script>
<script src="/js/ptech/news/news-result.js?timestamp=201908061440"></script>

<script src="/js/ptech/news/visualization/preview-data.js?timestamp=201908061440"></script>
<script src="/js/ptech/news/visualization/trend-chart.js?timestamp=201908061440"></script>
<script src="/js/ptech/news/visualization/relational-word.js?timestamp=201908061440"></script>

<script src="/js/ptech/news/history-data.js?timestamp=201908061440"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.17/d3.min.js"></script>
<script src="/js/ext/d3.layout.cloud.js "></script>
<script src="https://cdn.zoomcharts-cloud.com/1/stable/zoomcharts.js"></script>
<script src="/js/ptech/analysis/chart-setting.js?timestamp=201908061440"></script>
<script src="/js/ptech/analysis/relationships.js?timestamp=201908061440"></script>
<script src="/js/ptech/analysis/info-extractor.js?timestamp=201908061440"></script>

<script src="/js/ext/gijgo-1.9.11.min.js"></script>
<script src="/js/ext/jexcel/jquery.jexcel.js"></script>
<script src="/js/ext/jquery.fileDownload-1.4.4.js"></script>
<script src="/js/ext/js-xlsx/shim.min.js"></script>
<script src="/js/ext/js-xlsx/xlsx.full.min.js"></script>
<script src="/js/ext/FileSaver.js"></script>
<script src="/js/ext/jscolor.js"></script>
<script src="/js/ext/canvg.min.js"></script>
<script src="/js/ext/download.min.js"></script>

<!-- Resources -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>

<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip({
            container: 'body'
        });

        new NewsDetail();

        var search = new Search();
        search.setValuesByParams({"indexName":"news","searchKey":"","searchKeys":[{}],"byLine":"","searchFilterType":"1","searchScopeType":"1","mainTodayPersonYn":"","startDate":"2019-06-27","endDate":"2019-09-27","newsIds":[],"categoryCodes":[],"incidentCodes":[],"networkNodeType":"","topicOrigin":""});
        new NewsResult(search, "2");
        new DictSearch(search);
    });
</script>
		</div>
<footer id="footer-wrapper">
    <div class="container">
        <div class="footer-top">
            <div class="row">
                <div class="col-xs-12 col-md-12">
                    <div class="footer-link" data-type="usage">이용약관</div>
                    <div class="footer-link" data-type="policy">개인정보취급방침</div>
                    <div class="footer-link" data-type="email-policy">이메일무단수집거부</div>
                </div>
            </div>
        </div>
        <div class="footer-content">
            <div class="row">
                <div class="col-xs-12 col-md-3">
                    <a href="http://www.kpf.or.kr/" target="_blank">
                        <img src="/images/footerLogo.png" alt="한국언론진흥재단 로고" class="img-responsive">
                    </a>
                </div>
                <div class="col-xs-12 col-md-9 text-right">
                    <div class="row mt-2">
                        <div class="col-xs-12 col-md-12">
                            <div class="info">멀티캠퍼스</div>
                            <div class="info">|</div>
                            <div class="info">5조</div>
                            <div class="info">|</div>
                            <div class="info">superpcw1080@naver.com</div>
                        </div>
                        <div class="col-xs-12 col-md-12 mt-2">
                            COPYRIGHTⓒ 2019 MultiCampus. ALL RIGHTS RESERVED.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<div id="news-detail-modal" class="modal fade printable"></div>
<div id="footer-modal" class="modal fade"></div>
<audio id="audio-player"></audio>

<div class="pageTopBtn hidden-xs" id="pageTopBtn"><img src="/images/topBtn.png" alt="맨위로가기"></div>
<script>
    $(function(){
        $("a[data-toggle='tooltip']").click(function(e) {
            e.preventDefault();
        });

       $(".footer-link, #sitemap-btn").click(function(){
           var type = $(this).data('type');
           var $footerModal = $("#footer-modal");

           switch (type) {
               case "usage":
                   var usageTemplate = Handlebars.getTemplate("footer/usage");
                   $footerModal.html(usageTemplate);
                   break;
               case "policy":
                   var policyTemplate = Handlebars.getTemplate("footer/policy");
                   $footerModal.html(policyTemplate);
                   break;
               case "email-policy":
                   var emailpoliyTemplate = Handlebars.getTemplate("footer/email-policy");
                   $footerModal.html(emailpoliyTemplate);
                   break;
               case "sitemap":
                   var sitemapTemplate = Handlebars.getTemplate("footer/sitemap");
                   $footerModal.html(sitemapTemplate);
           };
           $footerModal.modal('show');
       });
    });
</script>
<script>
    var ignorePatterns = [
        "/log/webLogAppend.do",
        "/api/news/webloadLogging.do",                  
        "/api/providers.do",
        "/api/categories.do",
        "/api/incidents.do",
        "/api/search/suggestKeywords.do",
        "/news/getSearchDic.do",
        "/news/levelTreeList.do",
        "/news/thesaurusSearch.do",
        "/news/thesauruslevelTreeList.do",
        "/news/shareDicSearch.do",
        "/news/getMyDicTreeSearch.do",
        "/api/mydic/:id/myDicTree.do",
        "/api/categoryKeywords.do",
        "/openPop.do",
        "/news/subMain.do",
        "/search/trendReport.do",
        "/api/opendata/fineDust.do",
        "/cmn/getProviderMediaCodeJson.do",
        "/interKoreaRelations/expertInfoList.do",
        "/news/getAssemblyRecords.do",
        "/news/getAssemblyBrief.do",
        "/news/getAssemblyPropose.do",
        "/news/newsInQuotaionList.do",
        "/news/getAssemblyWordCloud.do",
        "/news/relationNewsList.do",
        "/news/keywordTrendJson.do",
        "/news/getNewsIssueKeyword.do",
        "/news/getCompNetworkData.do",
        "/news/qnaList.do",
        "/news/commList.do",
        "/news/newsCase.do",
        "/api/private/expressions/:id/detail.do",
        "/api/account/checkEmail.do",
        "/api/myNews/createMyRecent.do",
        "/api/mydic/index.do",
        "/common/dummy.do"
    ];

    var regexPattern = [
        new RegExp("^/api/private/expressions/[0-9]+/detail.do$"),
        new RegExp("^/api/mydic/[0-9]+/myDicTree.do$")
    ];

    var newsSearchPattern = [
        "/news/getNewsToDayIssueList.do",
        "/news/detailView.do",
        "/api/news/search.do",
        "/api/private/expressions/index.do"
    ];

    var newsAnalysisPattern = [
        "/api/private/scrap/create.do",
        "/api/news/previewData.do",
        "/news/getNetworkDataAnalysis.do",
        "/news/nodeDetailData.do",
        "/api/analysis/keywordTrends.do",
        "/api/analysis/relationalWords.do",
        "/searchSyntaticPatternExtract.do",
        "/api/mydic/create.do",
        "/api/private/analysis/create.do",
        "/api/private/patterns/index.do",
        "/api/private/patterns/create.do",
    ];

    var loginPattern = [
        "/api/account/signin.do",
        "/oauth/kako/process.do",
        "/oauth/naver/process.do",
        "/oauth/google/process.do",
    ];

    var signupPattern = [
        "/v2/account/signup.do",
        "/api/account/signup.do"
    ];

    var profilePattern = [
        "/api/account/findId.do",
        "/api/account/findPassword.do",
        "/api/account/resendConfirmMail.do",
        "/v2/account/agreement.do",
        "/api/account/updateAgreement.do"
    ];

    var oauthPattern = [
        "/oauth/kakao/process.do",
        "/oauth/naver/process.do",
        "/oauth/google/process.do"
    ];

    $( document ).ajaxComplete(function( event, xhr, settings ) {
        var url = settings.url.split('?')[0];

        var matches = _.map(regexPattern, function(re) {
            return (url.match(re) == null) ? false : true;
        });
        var regFlag = _.find(matches, function(match) { return match; });

        if (ignorePatterns.indexOf(url) < 0
            && url.indexOf(".hbs") < 0
            && !regFlag) {

            if (newsSearchPattern.indexOf(url) >= 0) {
                sendPageView('BigKinds - 뉴스 검색', url);
            }
            else if (newsAnalysisPattern.indexOf(url) >= 0) {
                sendPageView('BigKinds - 뉴스 분석', url);
            }
            else if (loginPattern.indexOf(url) >= 0) {
                sendPageView('BigKinds - 로그인', url);
            }
            else if (signupPattern.indexOf(url) >= 0) {
                sendPageView('BigKinds - 회원가입', url);
            }
            else if (profilePattern.indexOf(url) >= 0) {
                sendPageView('BigKinds - 마이페이지 - 나의 정보', url);
            } else {
                ga('send', 'pageview', url);
            }
        }
    });

    function sendPageView(title, url) {
        ga('send', {
            hitType: 'pageview',
            title: title,
            page: url
        });
    }

    $(document).on("click", ".oauth-login-btn", function() {
        var type = $(this).data('type');
        var url = "/oauth/" + type + "/login.do";
        sendPageView('BigKinds - Oauth', url);
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script src="/js/ptech/auth.js?timestamp=201908061440"></script>


<script type="text/javascript">
$(function () {
    $('[data-toggle="tooltip"]').tooltip();
});
</script>

        <script>
        $().ready(function () {
            $('.modal.printable').on('shown.bs.modal', function () {
                $('.modal-dialog', this).addClass('focused');
                $('body').addClass('modalprinter');
            }).on('hidden.bs.modal', function () {
                $('.modal-dialog', this).removeClass('focused');
                $('body').removeClass('modalprinter');
            });
        });
        </script>
    </body>
</html>