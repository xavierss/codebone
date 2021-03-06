<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ page
	import="java.util.*,{{package}}.*,org.codebone.framework.BaseModel,java.util.Date,org.codebone.framework.util.PagingNavigation"%>
<%
	BaseModel baseModel = (BaseModel) request.getAttribute("data");
	List<{{tableNameCamelcase}}> list = (List<{{tableNameCamelcase}}>) baseModel.getData();
	boolean hasNext = baseModel.isHasNext();
	int allCount = baseModel.getAllCount();
	int currentPage = (Integer) request.getAttribute("page");
%>

<section id="contents">
	<table class="table">
		<thead>
			<tr>
				{{#columns}}
				{{^foreignKey}}
				<th>{{description}}</th>
				{{/foreignKey}}
				{{/columns}}
			</tr>
		</thead>

		<tbody>
			<%
				for ({{tableNameCamelcase}} model : list) {
			%>
			<tr>
				{{#columns}}
				{{^foreignKey}}
				<td><%=model.get{{nameCamelcase}}()%></td>
				{{/foreignKey}}
				{{/columns}}

				<td>
					<div class="btn-group">
						<a class="btn btn-small"
							href="<%=request.getContextPath()%>/app/{{mappingUri}}/update?idx=<%=model.get{{primaryKeyCamelcase}}().toString()%>">
							<i class="icon-edit"></i> Update
						</a> <a class="btn btn-small"
							href="<%=request.getContextPath()%>/app/{{mappingUri}}/delete?idx=<%=model.get{{primaryKeyCamelcase}}().toString()%>">
							<i class="icon-trash"></i> Delete
						</a>
					</div>
				</td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</section>

<section id="operation">
	<div class="row-fluid">
		<div class="pull-left">
			<a class="btn"
				href="<%=request.getContextPath()%>/app/{{mappingUri}}/create">
				<i class="icon-pencil"></i> Create
			</a>
		</div>
		
		<div class="pull-right">
		<form class="form-search"
			action="<%=request.getContextPath()%>/app/{{mappingUri}}/search"
			method="post">

			<div class="input-append">
				<div>
					{{#columns}}
					{{#searchable}}
					<label class="checkbox inline">
						<input name="property" type="checkbox" value="{{name}}">{{description}}
					</label>
					{{/searchable}}
					{{/columns}}
				</div>
				<input type="text" class="search-query" name="keyword">
				<button type="submit" class="btn">Search</button>
			</div>
		</form>
		</div>
	</div>
</section>

<section id="navigation">
	<div class="row-fluid">
		<%
			PagingNavigation pagingNavigation = new PagingNavigation();
			pagingNavigation.setCurrentPage(currentPage + 1);
			pagingNavigation.setPagePerBlock(5L);
			pagingNavigation.setRecordPerPage(20L);
			pagingNavigation.setTotalRecord(allCount);
			pagingNavigation.setHref("list");
			pagingNavigation.setParamters("");
			out.println(pagingNavigation.getHtml());
		%>
	</div>
</section>