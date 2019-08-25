# TODO コマンド実行はinfra層に移譲し、infraのモジュールをDI
# TODO 事前にdocker pullするシェルなどの用意
# FIXME タイムアウト考慮
# FIXME メモリのAllocSize制限
defmodule CodeService do
    import ErrorHandler

    @workspace_base "/docker_workspace"

    # ジョブキューとして実行すると実行後のハンドリングが楽かもしれない
    def exec(lang, source) do
        {docker_cmd_suffix, file_path} = lang |> getCommandSuffix

        # write code to file
        write_file_src = System.cwd() <> @workspace_base <> file_path
        File.write(write_file_src, source)

        # find cmd
        cmd_path = "docker" |> System.find_executable
        if !cmd_path do
            raise ErrorHandler.errors[:command_find_error]
        end

        # exec on Docker
        cmd_options = String.split(docker_cmd_suffix, " ")
        {exec_result, error} = System.cmd(cmd_path, cmd_options)
        if error == 1 do
            raise ErrorHandler.errors[:command_execution_error]
        end

        exec_result
    end

    # Private commands/queries

    defp getCommandSuffix(lang) do
        cmd_suffix = "run -v " <> System.cwd

        cmd_suffix = case lang do
            "go" -> {
                cmd_suffix <> "#{@workspace_base}/go:/go/src/app -w /go/src/app -t golang go run main.go",
                "/go/main.go"
            }
            "python" -> {
                cmd_suffix <> "#{@workspace_base}/python:/app -w /app -t python python main.py",
                "/python/main.py"
            }
            "elixir" -> {
                cmd_suffix <> "#{@workspace_base}/elixir:/build -w /build -t elixir elixir main.ex",
                "/elixir/main.ex"
            }
            "node" -> {
                cmd_suffix <> "#{@workspace_base}/node/:/usr/src/app -w /usr/src/app -t node node main.js",
                "/node/main.js"
            }
        end

        cmd_suffix
    end

end
