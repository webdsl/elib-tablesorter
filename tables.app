module elib-tablesorter/tables

	define sortedTableBordered( pageSize :  Int){
		var pageSizes : Set<Int> := {pageSize,5,10,25,50,100};
		var idAttr := attribute("id");
		var elemId := if (idAttr != "") idAttr else randomUUID().toString();
		var pagerStyle:= "width: 100%;  display: block; padding: 4px 4px; border-style: inherit; border: 1px solid #dddddd;border-bottom-style: hidden;border-radius: 4px 60px 0px 0px; position: inherit; text-align: inherit;";
		includeCSS("theme.bootstrap.css")
		includeJS("jquery.tablesorter.min.js")
		includeJS("jquery.tablesorter.widgets.min.js")
		includeJS("jquery.tablesorter.pager.min.js")
		includeJS("tablesorter-init.js")
		<script>
			$(document).ready(function(){
				  initTableSorter( "~elemId", ~pageSize );
			}); 
		</script>
				
		<span id="pager"+elemId style=pagerStyle>
			buttonGroup{
				pagerButton("first"){ iFastBackward }
				pagerButton("prev"){ iBackward }
				pagerButton("pagedisplay"){ " " } 
				pagerButton("next"){ iForward}
				pagerButton("last"){ iFastForward }
			} " "
			<input placeholder="filter" id="search"+elemId /> " "
			<select class="pagesize input-mini" title="Select page size">
				for( p in pageSizes order by p){
					<option value=""+p>output(p)</option>
				}
			</select>
        </span>
		tableBordered[id=elemId, all attributes except "id"]{
			elements
		}
	}
	define pagerButton(class : String){
		<button type="button" class="btn btn-default btn-sm " + class>elements</button>
	}
	define makeSortable( order : String ){
		<span style="display:none;"> output(order) </span>
	}