## -*- coding: utf-8 -*-
## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

<%namespace name="common" file="workflow-common.xml.mako" />

    <action name="${ node['name'] }"${ common.credentials(node['properties']['credentials']) }>
        <java>
            <job-tracker>${'${'}jobTracker}</job-tracker>
            <name-node>${'${'}nameNode}</name-node>

            ${ common.prepares(node['properties']['prepares']) }
            % if node['properties']['job_xml']:
              <job-xml>${ node['properties']['job_xml'] }</job-xml>
            % endif
            ${ common.configuration(node['properties']['job_properties']) }

            <main-class>${ node['properties']['main_class'] }</main-class>

            % if node['properties']['java_opts']:
            <java-opts>${ node['properties']['java_opts'] }</java-opts>
            % endif

            % for arg in node['properties']['arguments']:
            <arg>${ arg['value'] }</arg>
            % endfor

            ${ common.distributed_cache(node['properties']['files'], node['properties']['archives']) }

            % if node['properties']['capture_output']:
            <capture-output/>
            % endif
        </java>
        <ok to="${ node_mapping[node['children'][0]['to']].name }"/>
        <error to="${ node_mapping[node['children'][1]['error']].name }"/>
        ${ common.sla(node) }
    </action>
