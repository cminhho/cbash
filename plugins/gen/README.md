## `cbash gen trouble`
```
USAGE
  $ cbash gen trouble [NAME]

ARGUMENTS
  NAME  trouble name

DESCRIPTION
  Generate trouble directory

EXAMPLES
  $ cbash gen trouble

OUTPUT
yyyy-mm-dd
├── README.md
└── troubleshooting.log
```

## `cbash gen feature`
```
USAGE
  $ cbash gen feat [NAME]

ARGUMENTS
  NAME  feature name

DESCRIPTION
  Generate feature directory

EXAMPLES
  $ cbash gen feature demo

OUTPUT
├── 1_Concept
├── 2_Definition
│   ├── 1_Architecture
│   ├── 2_Requirements
│   └── 3_Design
├── 3_Development
│   ├── API-Spects
│   ├── Database
│   ├── Kafka
│   └── S3
├── 4_Testing
├── 5_Release
├── 6_Deployment
├── 7_Operations
├── 8_Reporting
└── 9_Assets
```

OUTPUT

## `cbash gen workspace`
```
USAGE
  $ cbash gen workspace [NAME]

ARGUMENTS
  NAME  workspace name

DESCRIPTION
  Generate workspace directory

EXAMPLES
  $ cbash gen workspace worksapce

OUTPUT
worksapce
├── archive
│   └── <year>
├── artifacts
│   ├── business
│   │   ├── logs
│   │   ├── m2
│   │   ├── secrets
│   │   └── volumes
│   └── personal
│       ├── logs
│       ├── m2
│       ├── secrets
│       └── volumes
├── business
│   ├── playground
│   ├── sourcecode
│   └── troubleshoot
│       └── <year>
├── devbox
├── documents
│   ├── business
│   │   ├── products
│   │   └── training
│   └── personal
│       ├── finances
│       └── health
├── personal
│   ├── playground
│   ├── private
│   └── public
├── softs
└── tmp
    └── <year>
```