module elib-tablesorter/tables

	define sortedTableBordered(){
		var idAttr := attribute("id");
		var elemId := if (idAttr != "") idAttr else randomUUID().toString();
		includeCSS("theme.bootstrap.css")
		includeJS("jquery.tablesorter.min.js")
		includeJS("jquery.tablesorter.widgets.min.js")
		includeJS("jquery.tablesorter.pager.min.js")
		includeJS("tablesorter-init.js")
		<script>
			$(document).ready(function(){
				  initTableSorter( "~elemId" );
			}); 
		</script>
		
		tableBordered[id=elemId, all attributes except "id"]{
			elements
			<tfoot>row{<th id="pager"+elemId colspan="42">
			buttonGroup{
				pagerButton("first"){ iFastBackward }
				pagerButton("prev"){ iBackward }
				pagerButton("pagedisplay"){ " " } 
				pagerButton("next"){ iForward}
				pagerButton("last"){ iFastForward }
			} " "
			<input placeholder="filter" id="search"+elemId /> " "
			<select class="pagesize input-mini" title="Select page size">
				<option selected="selected" value="10">"10"</option>
				<option value="20">"20"</option>
				<option value="30">"30"</option>
				<option value="40">"40"</option>
			</select>
	        
	        </th>}
			</tfoot>
		}
	}
	define pagerButton(class : String){
		<button type="button" class="btn btn-default btn-sm " + class>elements</button>
	}
	define makeSortable( order : String ){
		<span style="display:none;"> output(order) </span>
	}