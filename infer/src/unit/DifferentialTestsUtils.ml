(*
 * Copyright (c) 2017-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd

let create_fake_jsonbug ?(kind = "kind") ?(bug_type = "bug_type") ?(qualifier = "qualifier")
    ?(severity = "severity") ?(visibility = "visibility") ?(line = 1) ?(column = 1)
    ?(procedure = "procedure") ?(procedure_start_line = 1) ?(file = "file/at/a/certain/path.java")
    ?(bug_trace = []) ?(node_key = "File|method|TYPE") ?(key = "1234") ?(hash = "1")
    ?(dotty = None) ?(infer_source_loc = None) ?(linters_def_file = Some "file/at/certain/path.al")
    ?doc_url () : Jsonbug_t.jsonbug =
  { kind
  ; bug_type
  ; qualifier
  ; severity
  ; visibility
  ; line
  ; column
  ; procedure
  ; procedure_start_line
  ; file
  ; bug_trace
  ; node_key
  ; key
  ; hash
  ; dotty
  ; infer_source_loc
  ; bug_type_hum= kind
  ; linters_def_file
  ; doc_url
  ; traceview_id= None
  ; censored_reason= ""
  ; access= None
  ; extras= None }


let pp_diff_of_list ~pp group_name fmt (expected, actual) =
  Format.fprintf fmt "[%s]: Expected: [%a] Found: [%a]" group_name (Pp.comma_seq pp) expected
    (Pp.comma_seq pp) actual


let pp_diff_of_string_list = pp_diff_of_list ~pp:Format.pp_print_string

let pp_diff_of_int_list = pp_diff_of_list ~pp:Format.pp_print_int

(* Sort hashes to make things easier to compare *)
let sorted_hashes_of_issues issues =
  let hash i = i.Jsonbug_t.hash in
  List.sort ~compare:String.compare (List.rev_map ~f:hash issues)
