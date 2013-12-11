module elib/elib-tablesorter/lib

	define tablesorterIncludes(){
		includeCSS("theme.bootstrap.css")
		includeJS("jquery-1.8.2.min.js")
		includeJS("jquery.tablesorter.min.js")
		includeJS("jquery.tablesorter.widgets.min.js")
		includeJS("jquery.tablesorter.pager.min.js")
		includeJS("tablesorter-init.js")
	}

	define sortedTableBordered( pageSize :  Int){
		var pageSizes : Set<Int> := {pageSize,5,10,25,50,100};
		var idAttr := attribute("id");
		var elemId := if (idAttr != "") idAttr else randomUUID().toString();
		var pagerStyle:= "width: 100%;  display: block; padding: 4px 30px 4px 30px; background-color: #eeeeee;border-style: inherit; border: 1px solid #ddd;border-bottom-style: hidden; position: inherit; text-align: center;";
		var pagerStyleBottom:= "width: 100%;  display: block; padding: 4px 30px 4px 4px; border-style: inherit; border: 1px solid #dddddd;border-top-style: hidden;background-color: #eeeeee; position: inherit; text-align: center; margin-bottom: 20px;";
		
		tablesorterIncludes()
		
		<script>
			$(document).ready(function(){
				  initTableSorter( "~elemId", ~pageSize );
			}); 
		</script>
				
		<span class="pager"+elemId style=pagerStyle>
			<input type="search" placeholder="Type to filter" id="search"+elemId /> 
			<span class="small">" showing: " <span class="pagedisplay">" "</span></span>
        </span>
		tableBordered[id=elemId, style="margin-bottom: 0px; "+attribute("style") , all attributes except ["id","style"] ]{
			elements
		}
		<span class="pager"+elemId style=pagerStyleBottom>
			buttonGroup{
				pagerButton("first"){ iFastBackward }
				pagerButton("prev"){ iBackward }
				pagerButton("pagedisplay"){ " " } 
				pagerButton("next"){ iForward}
				pagerButton("last"){ iFastForward }
			} " "
			<select class="pagesize input-mini" title="Select page size">
				for( p in pageSizes order by p){
					<option value=""+p>output(p)</option>
				}
			</select>
        </span>
	}
	define pagerButton(class : String){
		<button type="button" class="btn btn-default btn-sm " + class>elements</button>
	}
	define makeSortable( order : String ){
		<span style="display:none;"> output(order) </span>
	}