import qbs
import qbs.File

Product {
    name: "qbs custom resources"
    Group {
        files: ["qbs"]
        qbs.install: true
        qbs.installDir: project.resourcesInstallDir + "/share"
    }

    Transformer {
        inputs: "qbs"
        Artifact {
            filePath: project.buildDirectory + '/' + project.resourcesInstallDir + "/share/qbs"
        }
        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.description = "Copying share/qbs to build directory.";
            cmd.highlight = "codegen";
            cmd.sourceCode = function() { File.copy(input.filePath, output.filePath); }
            return cmd;
        }
    }
}
