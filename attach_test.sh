GO_FILE=$(cat <<EOS
package main
import (
    "fmt"
    "os/exec"
)
func main() {
    fmt.Println("print from test.sh")
    out, err := exec.Command("pwd").Output()
    if err != nil {
        panic(err)
    }
    fmt.Println(string(out))
}
EOS
)

targetDir="$(pwd)/server/docker_workspace/go"
echo "$GO_FILE" > "${targetDir}/main.go"

docker run -v $targetDir:/go/src/app -w /go/src/app -it golang go run main.go
