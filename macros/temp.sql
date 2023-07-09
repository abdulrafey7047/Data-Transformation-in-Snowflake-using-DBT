{% macro export_from_snowflake_to_s3(stagedb, stagename, filepath, filename, query, partitionbyoptions, fileformat, copyoptions, header) -%}

    {{ log("Unloading data", True) }}
    {% call statement('unload_test', fetch_result=true, auto_begin=true) %}
        use database {{ stagedb }};
        use schema CONFIG;
        {{ log("Using schema", True) }}
        copy into @{{ stagename }}/{{ filepath}}{{ filename }}
        from ({{ query }})
        {{ partitionbyoptions }}
        {{ fileformat }}
        {{ copyoptions }}
        {{ header }}
    {% endcall %}
    {{ log("Unloaded data", True) }}

{%- endmacro %}