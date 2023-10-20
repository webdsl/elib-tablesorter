module elib/elib-tablesorter/lib

define tablesorterIncludes(){
  includeCSS("theme.bootstrap.min.css")
  includeJS(IncludePaths.jQueryJS())
  includeJS("jquery.tablesorter.combined.min.js")
  includeJS("jquery.tablesorter.pager.min.js")
  includeJS("tablesorter-init.js")
}


define sortedTableBordered( pageSize :  Int){
  sortedTableBordered( pageSize, true, true )[ all attributes ]{ elements }
}

define sortedTableBordered( pageSize : Int, numberOfElemRows : Int ){
  sortedTableBordered(pageSize, numberOfElemRows > pageSize, true)[ all attributes ]{ elements }
}

define sortedTableBordered( pageSize : Int, showSearch : Bool, numberOfElemRows : Int){
  if( numberOfElemRows > pageSize ){
    sortedTableBordered(pageSize, showSearch, true)[ all attributes ]{ elements }
  } else{
    sortedTableBordered(pageSize, showSearch, false)[ all attributes ]{ elements}
  }
}

define sortedTableBordered( pageSize :  Int, showSearch : Bool, showPagination : Bool){
  var pageSizesStr := List<String>()
  var selectedPageSize := "all"
  var idAttr := attribute("id")
  var elemId := if (idAttr != "") idAttr else id
  var placeholderAttr := attribute("placeholder")
  var placeholderText := if (placeholderAttr != "") placeholderAttr else "Search Table"
  var pagerStyle:= "width: 100%;  display: block; padding: 4px 30px 4px 30px; background-color: #eeeeee;border-style: inherit; border: 1px solid #ddd;border-bottom-style: hidden; position: inherit; text-align: center;"
  var pagerStyleBottom:= "width: 100%;  display: block; padding: 4px 30px 4px 4px; border-style: inherit; border: 1px solid #dddddd;border-top-style: hidden;background-color: #eeeeee; position: inherit; text-align: center; margin-bottom: 20px;"

  tablesorterIncludes()
  init{
    if(showPagination){
      var pageSizes := [10, 25, 50, 100, 200, 500, 1000, 2000];
      var idx := 0;
      
      while( idx < 4 || (idx < pageSizes.length && pageSize > pageSizes.get(idx-1) ) ){
        var size := pageSizes.get(idx);
        pageSizesStr.add( "" + size );
        if(selectedPageSize == "all" && size > pageSize){
          selectedPageSize := ""+size;
        }
        idx := idx + 1;
      }
      pageSizesStr.add("all");
    }
  }

  <script>
    $(document).ready(function(){
      try{
        initTableSorter( "~elemId", "~selectedPageSize" );
      } catch (err){
        console.log("Failed to initialize tablesorter for table (id: ~elemId) - table may be empty.");
      }
    });
  </script>
  if(showPagination || showSearch){
    <div class="form-horizontal pager"+elemId style=pagerStyle>
      gridRow{gridCol(4,4){
        if(showSearch){
          <input type="search" class="form-control" placeholder=placeholderText id="search"+elemId data-column="all" if(attribute("autofocus") != ""){ autofocus="true" } />

        }
        helpBlock{
          if(showSearch){
            small{ "Use '|' to match " <em>"multiple|terms. "</em> }
            br
          }
          small{ " Showing: " <span class="pagedisplay">" "</span> }
        }
      } }
    </div>
  }
  tableBordered[id=elemId, style="margin-bottom: 0px; "+attribute("style") , all attributes except ["id","style", "autofocus"] ]{
    elements
  }
  if(showPagination){
    
    <center class="form-inline pager"+elemId style=pagerStyleBottom>      
        buttonGroup{
          pagerButton("first"){ iFastBackward }
          pagerButton("prev"){ iBackward }
          pagerButton("pagedisplay"){ " " }
          pagerButton("next"){ iForward}
          pagerButton("last"){ iFastForward }
        }
        <select class="pagesize input-sm form-control" title="Select page size">
          for( p in pageSizesStr){
            <option value=p> ~p </option>
          }
        </select>
  </center>
  
  }
  //move modals outside table, to improve tablesorter initialization speed
  <script> var tbl= $('table#~elemId'); tbl.find('tbody>tr>td .modal').insertAfter( tbl ); </script>
}
define pagerButton(class : String){
  <button type="button" class="btn btn-default btn-sm " + class>elements</button>
}
define makeSortable( order : String ){
  <span style="display:none;"> output(order) </span>
}
define makeSortable(){
  <span style="display:none;"> elements </span>
}