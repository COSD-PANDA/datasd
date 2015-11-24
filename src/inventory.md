---
layout: page
title: Inventory
---

<div id="inventory-table">
    <table 
    cellpadding="0" 
    cellspacing="0" 
    border="0" 
    class="table table-striped table-condensed" 
    id="invTable">
    <thead>
        <tr>
            <th>Bucket</th>
            <th>PriorityLevel</th>
            <th>DatasetName</th>
            <th>Description</th>
            <th>Department</th>
            <th>Vote</th>
        </tr>
    </thead>
    <tbody>

        {% for invRow in site.data.inventory %}
            {% if invRow.Bucket %}
                <tr>
                    <td> {{ invRow.Bucket }} </td>
                    <td> {{ invRow.PriorityLevel }} </td>
                    <td> {{ invRow.DatasetName }} </td>
                    <td> {{ invRow.Description }} </td>
                    <td> {{ invRow.Department }} </td>
                    <td> 
                        <a target="_blank" href="http://sdcdo.wufoo.com/forms/dataset-vote/def/field6={{ invRow.ID }}_{{ invRow.DatasetName | downcase | replace:' ','-' }}">Vote</a> 
                    </td>
                </tr>
            {% endif %}
        {% endfor %}

    <tbody>

    </table>
</div>
