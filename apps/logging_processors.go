// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package apps

type LoggingProcessorParseJson struct {
	ConfigComponent             `yaml:",inline"`
	LoggingProcessorParseShared `yaml:",inline"`
}

func (r LoggingProcessorParseJson) Type() string {
	return "parse_json"
}

func init() {
	confgenerator.LoggingProcessorTypes.RegisterType(func() component { return &LoggingProcessorParseJson{} })
}

type LoggingProcessorParseRegex struct {
	ConfigComponent             `yaml:",inline"`
	LoggingProcessorParseShared `yaml:",inline"`

	Regex string `yaml:"regex,omitempty" validate:"required"`
}

func (r LoggingProcessorParseRegex) Type() string {
	return "parse_regex"
}

func init() {
	confgenerator.LoggingProcessorTypes.RegisterType(func() component { return &LoggingProcessorParseRegex{} })
}
