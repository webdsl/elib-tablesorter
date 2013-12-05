elib-tablesorter
================

Includes a table template allowing sorting, filtering, pagination. Currently using bootstrap theming. Based on https://github.com/Mottie/tablesorter


### Requirements

The template is currently designed to use with bootstrap. In order to work properly, it requires:

 - importing `elib/elib-tablesorter/lib`
 - a `theader` with  at least one `row` with `th`'s in it.
 - a `tbody`. This automatically gets wrapped around rows outside a `theader` and `tfooter`

### Tweaking:

 - Sorting can be disabled per column by adding the `class="sorter-false"` attribute to a `th`.
 - Sorting is primarily done in alphabetic order, but can be adapted by starting the content of a column cell using the hidden template `makeSortable( order: : String )`. `makeSortable` can also be used anywhere in a column cell to have additional searchable data to each cell which you don't want to get displayed.
 

### Example
The template signature is `sortedTableBordered( defaultPageSize : Int )`. Example:
 
```
sortedTableBordered(25){
	theader{ row {
		th{ "Student"     }
		th[class="sorter-false"]{ "Submissions" }
    		th{ "Started"     }
		th{ "Completed"   }
		th{ "Grade"       }
		th{ "Passed"      }
	} }
	for(s in students) {
		studentRow(s)
	}
}
```