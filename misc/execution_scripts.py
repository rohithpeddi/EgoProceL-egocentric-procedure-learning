import os


def create_execution_scripts(path):
	with open("execution_scripts.txt", "w") as execution_file:
		for file in os.listdir(path):
			script = ""
			if os.path.isfile(os.path.join(path, file)):
				script += f"python -m RepLearn.TCC.main --cfg configs/{file}"
				execution_file.write(script + "\n")


if __name__ == '__main__':
	create_execution_scripts("../configs/")
