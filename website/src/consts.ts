// Single source of truth for links + product data (from README / registry).

export const GITHUB = "https://github.com/cminhho/cbash";
export const BREW_CMD = "brew install cminhho/tap/cbash-cli";
export const CURL_CMD =
  'sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"';

export const NAV = [
  { name: "Features", href: "#features" },
  { name: "Plugins", href: "#plugins" },
  { name: "Install", href: "#install" },
  { name: "Architecture", href: "#architecture" },
];

export interface Plugin {
  name: string;
  icon: string;
  blurb: string;
  commands: string[];
}

// Mirrors the plugin set in the cbash README.
export const PLUGINS: Plugin[] = [
  { name: "Git", icon: "lucide:git-branch", blurb: "Multi-repo workflows from one command.", commands: ["clone-all", "pull-all", "auto-commit", "gitfor", "auto-squash"] },
  { name: "Docker & Dev", icon: "lucide:container", blurb: "Drive Compose & local dev stacks.", commands: ["dev start", "compose-up", "logs", "exec"] },
  { name: "Kubernetes", icon: "lucide:ship-wheel", blurb: "Pods, logs, rollouts, exec.", commands: ["k8s pods", "k8s logs", "rollout"] },
  { name: "AWS", icon: "lucide:cloud", blurb: "SSM sessions & parameters.", commands: ["aws ssm", "ssm-param"] },
  { name: "AI & Docs", icon: "lucide:bot", blurb: "Local Ollama chat + doc scaffolding.", commands: ["ai chat", "cheatsheet", "doc gen"] },
  { name: "System & Proxy", icon: "lucide:settings", blurb: "Ports, proxy, passwords, macOS helpers.", commands: ["system ports", "proxy", "pass-gen"] },
];

export interface CommandRef {
  name: string;
  desc: string;
}
export interface PluginCommands {
  group: string;
  icon: string;
  commands: CommandRef[];
}

export const COMMAND_REFERENCE: PluginCommands[] = [
  {
    group: "Git plugin",
    icon: "lucide:git-branch",
    commands: [
      { name: "cbash git clone-all", desc: "Clone all repositories from a list" },
      { name: "cbash git pull-all", desc: "Pull every local repository" },
      { name: "cbash git auto-commit", desc: "Stage, commit, and push" },
      { name: "cbash git auto-squash", desc: "Squash a feature branch" },
      { name: "cbash git gitfor", desc: "Run a command across repos" },
    ],
  },
  {
    group: "DevOps plugin",
    icon: "lucide:container",
    commands: [
      { name: "cbash dev start", desc: "Start the dev environment" },
      { name: "cbash docker compose-up", desc: "Start Docker Compose services" },
      { name: "cbash k8s pods", desc: "List Kubernetes pods" },
      { name: "cbash aws ssm", desc: "Connect via AWS SSM" },
    ],
  },
  {
    group: "AI & Docs plugin",
    icon: "lucide:bot",
    commands: [
      { name: "cbash ai chat", desc: "Chat with local Ollama models" },
      { name: "cbash ai cheatsheet", desc: "Generate command cheatsheets" },
      { name: "cbash doc gen", desc: "Generate docs from templates" },
    ],
  },
  {
    group: "System plugin",
    icon: "lucide:settings",
    commands: [
      { name: "cbash system proxy", desc: "Enable / disable / show proxy" },
      { name: "cbash system ports", desc: "Scan listening ports" },
      { name: "cbash system pass-gen", desc: "Generate secure passwords" },
      { name: "cbash macos cleanup", desc: "macOS maintenance helpers" },
    ],
  },
];
