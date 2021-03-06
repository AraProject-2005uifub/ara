note
	description: "Class makes an HTML page with table(s). It is not commented and cheched well, so it would be better."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_PAGE_WITH_TABLE

create
	make, make_from_several_arrays

feature -- Init
	make(data_table: ARRAY2[STRING])
	require
		data_table_not_void: data_table /= Void
		data_table_not_empty: not data_table.is_empty
	do
		table := create {ARRAY[ARRAY2[STRING]]}.make_from_array (<<data_table>>)
	ensure
		table_set: not table.is_empty
	end

	make_from_several_arrays (data_table: ARRAY[ARRAY2[STRING]])
	require
		data_table_not_void: data_table /= Void
		data_table_not_empty: not data_table.is_empty
	do
		table := data_table
	ensure
		table_set: not table.is_empty
	end

feature -- Only one
	create_html_from_local_table: STRING
	local
		html_string: STRING
		i,j: INTEGER
	do
		html_string := "[
		<html lang="en">
		<head>
  <title>Ara Project | Report</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
]"
+
	generate_html_of_tables
+
"[
</body>
</html>
	]"
	Result := html_string
	end
feature -- Access
	table: ARRAY[ARRAY2[STRING]]

feature -- Realization

	generate_html_of_tables: STRING
		local
			table_str: STRING
			t, i, j: INTEGER
		do
			from
				t := 1
				table_str := ""
			until
				t > table.count
			loop

			table_str := table_str + "[
<div class="container">
  <h2>Report generated by Ara Project</h2>           
  <table class="table">
    <thead>
      <tr>
]"

	from
		i := 1
	until
		i > table.at (t).width
	loop
		table_str := table_str + "<th>" + table.at (t).item (1, i)+"</th>"
		i := i + 1
	end
	table_str := table_str + "[
		</tr>
    </thead>
    <tbody>
      ]"
	from
		i := 2
	until
		i > table.at (t).height
	loop
		table_str := table_str + "[
		<tr>
		]"
		from
			j := 1
		until
			j > table.at (t).width
		loop
			table_str := table_str + "<td>" + table. at(t).item (i, j) + "</td>"
			j := j + 1
		end
		table_str := table_str +"[
		</tr>
		]"
		i := i + 1
	end
	table_str := table_str + "[
	</tbody>
  </table>
</div>
]"
t := t + 1
end
Result := table_str
end
end
