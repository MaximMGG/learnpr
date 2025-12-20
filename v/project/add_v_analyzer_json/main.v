module main

import os



fn main() {
    v_analyzer_json := "
{
    \"enableExperimentalFeatures\": true,            
    \"global_vroot_path\": \"/home/maxim/progs/v\",
    \"additionalRoots\": [\".\"]
}
"

    if os.exists("./v-analyzer.json") {
        println("v-analyzer.json already exists")
        return
    } else {
        mut f := os.create("v-analyzer.json") or {
            return
        }
        defer {
            f.close()
        }
        write_bytes := f.write(v_analyzer_json.bytes()) or {return}
        if write_bytes != v_analyzer_json.len {
            eprintln("${write_bytes} != ${v_analyzer_json.len}")
            return
        }
    }
}
