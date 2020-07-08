package mailu

import "encoding/yaml"

command: dump: {
	task: print: {
		kind: "print"
		text: yaml.MarshalStream(objects)
	}
}

command: validate: {
	task: kubeval: {
		kind:  "exec"
		cmd:   "kubeval --filename \"cue\""
		stdin: yaml.MarshalStream(objects)
	}
}
