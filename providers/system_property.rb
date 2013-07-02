#
# Copyright Peter Donald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::Asadmin

use_inline_resources

action :set do
  bash "asadmin_create_system_properties #{new_resource.key}=#{new_resource.value}" do
    not_if "#{asadmin_command("list-system-properties")} | grep -x -- '#{new_resource.key}=#{new_resource.value}'"
    user new_resource.system_user
    group new_resource.system_group
    code asadmin_command("create-system-properties '#{new_resource.key}=#{new_resource.value}'")
  end
end
