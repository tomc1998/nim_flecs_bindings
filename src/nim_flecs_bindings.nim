import os
import nimterop/[build, cimport]

setDefines(@["flecsGit"])

const
  baseDir = getProjectCacheDir("nim_flecs_bindings")

getHeader(
  header = "flecs.h",
  giturl = "https://github.com/SanderMertens/flecs",
  outDir = baseDir,
)

# Wrap headerPath as returned from getHeader() and link statically
# or dynamically depending on user input
#cImport(headerPath, recurse = true)

static:
  cDisableCaching()           # Regenerate Nim wrapper every time

cIncludeDir(flecsPath.parentDir())
cDefine("FLECS_NO_CPP")

static:
  cSkipSymbol(@[
    "ECS_ROLE_MASK", "ECS_ENTITY_MASK",
    "ECS_INSTANCEOF", "ECS_CHILDOF",
    "ECS_TRAIT", "ECS_AND", "ECS_OR",
    "ECS_XOR", "ECS_NOT", "ECS_SWITCH",
    "ECS_CASE"
  ])

cImport(flecsPath, recurse=true, dynlib=flecsLPath, flags = "-G__=_ -E__,_ -F_")

const 
  ECS_ROLE_MASK* = (cast[ecs_entity_t](0x000000FF) shl
      typeof(cast[ecs_entity_t](0x000000FF))(56))
  ECS_ENTITY_MASK* = (cast[ecs_entity_t]((not ECS_ROLE_MASK)))
  ECS_INSTANCEOF* = (cast[ecs_entity_t](0x000000FE) shl
      typeof(cast[ecs_entity_t](0x000000FE))(56))
  ECS_CHILDOF* = (cast[ecs_entity_t](0x000000FD) shl
      typeof(cast[ecs_entity_t](0x000000FD))(56))
  ECS_TRAIT* = (cast[ecs_entity_t](0x000000FC) shl
      typeof(cast[ecs_entity_t](0x000000FC))(56))
  ECS_AND* = (cast[ecs_entity_t](0x000000FB) shl
      typeof(cast[ecs_entity_t](0x000000FB))(56))
  ECS_OR* = (cast[ecs_entity_t](0x000000FA) shl
      typeof(cast[ecs_entity_t](0x000000FA))(56))
  ECS_XOR* = (cast[ecs_entity_t](0x000000F9) shl
      typeof(cast[ecs_entity_t](0x000000F9))(56))
  ECS_NOT* = (cast[ecs_entity_t](0x000000F8) shl
      typeof(cast[ecs_entity_t](0x000000F8))(56))
  ECS_CASE* = (cast[ecs_entity_t](0x000000F7) shl
      typeof(cast[ecs_entity_t](0x000000F7))(56))
  ECS_SWITCH* = (cast[ecs_entity_t](0x000000F6) shl
      typeof(cast[ecs_entity_t](0x000000F6))(56))
