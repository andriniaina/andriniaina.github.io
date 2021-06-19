---
title: "SqlAlchemy notes"
date: 2021-06-19T12:36:40+02:00
draft: false
toc: false
images:
tags:
  - sql
---

Ordere list of strings
===
```py

@dataclass
class ChildEntity:
    label: str
    id: Optional[int] = None

@dataclass
class ParentChildEntity:
    activity_id: Optional[int] = None
    taxonomy_id: Optional[int] = None
    level: Optional[int] = None

    _taxonomy_obj: Optional[ChildEntity] = None

@dataclass
class ParentEntity:
    children: List[str] = field(default_factory=lambda: [])


child_table = Table(
    "child",
    metadata,
    Column("id", Integer, autoincrement=True, primary_key=True),
    Column("label", String),
)
prent_table = Table(
    "activity",
    metadata,
    Column("id", Integer, autoincrement=True, primary_key=True),
    ...
)
parent_child_table = Table(
    "parent_child",
    metadata,
    Column(
        "parent_id",
        Integer,
        ForeignKey(parent_table.c.id, ondelete="CASCADE"),
        primary_key=True,
    ),
    Column(
        "child_id",
        Integer,
        ForeignKey(child_table.c.id, ondelete="CASCADE"),
        primary_key=True,
    ),
    Column(
        "level",
        Integer,
        primary_key=True,
    ),
)

mapper(ChildEntity, child_table)
mapper(
    value_chain.activity.ParentChildEntity,
    parent_child_table,
    properties={
        "_child_obj": relationship(ChildEntity),
    },
)
mapper(
    ParentEntity,
    parent_table,
    properties={
        "_child_list": relationship(
            ParentChildEntity,
            order_by=ParentChildEntity.level,
            collection_class=ordering_list("level"),
        ),
    },
)
ParentEntity.children = association_proxy(
    "_child_list",
    "_child_obj.label",
    creator=lambda label: ParentChildEntity(
        _taxonomy_obj=ChildEntity(label)
    ),
)

```