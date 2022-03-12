## More Information About YAMLLint

For those of you who are unaware, [YAMLLint](https://github.com/adrienverge/yamllint) is a CLI tool that lints YAML files. It is well-received by the community and should be in anyone's arsenal when it comes to linting YAML files. It reports various issues that, when tended to, help reduce errors and improve the readability of YAML files.

## Pairing with ESLint

Sadly, YAMLLint does not have the ability to auto-fix/sort `*.yml` files. For that, you can use another JavaScript-based tool called [ESLint](https://eslint.org/). It can automatically fix some of the issues that YAMLLint reports. It can also sort your YAML files to your liking. It does require a decent amount of configuration though. If you would like to see some great examples that are ready for use, check out our ESLint shared configuration named [`eslint-config-strict-mode`](https://github.com/ProfessorManhattan/eslint-config-strict-mode) and our [GitLab-friendly CodeClimate engine for ESLint](https://github.com/ProfessorManhattan/codeclimate-eslint).
