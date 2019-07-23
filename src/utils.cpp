#include <utils.h>

#include <R_ext/Parse.h>

// -----------------------------------------------------------------------------
// Definitions initialized in rray_init_utils()

SEXP rray_ns_env = NULL;

SEXP syms_x = NULL;
SEXP syms_y = NULL;
SEXP syms_to = NULL;

SEXP rray_shared_empty_lgl = NULL;
SEXP rray_shared_empty_int = NULL;
SEXP rray_shared_empty_dbl = NULL;
SEXP rray_shared_empty_chr = NULL;

// -----------------------------------------------------------------------------
// r_new_environment()
// ripped from vctrs/src/utils.c

static void abort_parse(SEXP code, const char* why) {
  if (Rf_GetOption1(Rf_install("rlang__verbose_errors")) != R_NilValue) {
    Rf_PrintValue(code);
  }
  Rf_error("Internal error: %s", why);
}

SEXP r_parse(const char* str) {
  SEXP str_ = PROTECT(Rf_mkString(str));

  ParseStatus status;
  SEXP out = PROTECT(R_ParseVector(str_, -1, &status, R_NilValue));
  if (status != PARSE_OK) {
    abort_parse(str_, "Parsing failed");
  }
  if (Rf_length(out) != 1) {
    abort_parse(str_, "Expected a single expression");
  }

  out = VECTOR_ELT(out, 0);

  UNPROTECT(2);
  return out;
}

SEXP r_parse_eval(const char* str, SEXP env) {
  SEXP out = Rf_eval(PROTECT(r_parse(str)), env);
  UNPROTECT(1);
  return out;
}

// Also initialized in rray_init_utils()
static SEXP new_env_call = NULL;
static SEXP new_env__parent_node = NULL;
static SEXP new_env__size_node = NULL;

SEXP r_new_environment(SEXP parent, R_len_t size) {
  parent = parent ? parent : R_EmptyEnv;
  SETCAR(new_env__parent_node, parent);

  size = size ? size : 29;
  SETCAR(new_env__size_node, Rf_ScalarInteger(size));

  SEXP env = Rf_eval(new_env_call, R_BaseEnv);

  // Free for gc
  SETCAR(new_env__parent_node, R_NilValue);

  return env;
}

// -----------------------------------------------------------------------------

void rray_init_utils(SEXP ns) {
  rray_ns_env = ns;

  syms_x = Rf_install("x");
  syms_y = Rf_install("y");
  syms_to = Rf_install("to");

  rray_shared_empty_lgl = Rf_allocVector(LGLSXP, 0);
  R_PreserveObject(rray_shared_empty_lgl);
  MARK_NOT_MUTABLE(rray_shared_empty_lgl);

  rray_shared_empty_int = Rf_allocVector(INTSXP, 0);
  R_PreserveObject(rray_shared_empty_int);
  MARK_NOT_MUTABLE(rray_shared_empty_int);

  rray_shared_empty_dbl = Rf_allocVector(REALSXP, 0);
  R_PreserveObject(rray_shared_empty_dbl);
  MARK_NOT_MUTABLE(rray_shared_empty_dbl);

  rray_shared_empty_chr = Rf_mkChar("");
  R_PreserveObject(rray_shared_empty_chr);

  new_env_call = r_parse_eval("as.call(list(new.env, TRUE, NULL, NULL))", R_BaseEnv);
  R_PreserveObject(new_env_call);

  new_env__parent_node = CDDR(new_env_call);
  new_env__size_node = CDR(new_env__parent_node);
}
