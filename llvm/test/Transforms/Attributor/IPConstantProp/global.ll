; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes --check-attributes
; RUN: opt -attributor -enable-new-pm=0 -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=4 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=4 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -attributor-cgscc -enable-new-pm=0 -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM

@_ZL6test1g = internal global i32 42, align 4

define void @_Z7test1f1v() nounwind {
; IS__TUNIT____: Function Attrs: nofree nosync nounwind willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@_Z7test1f1v()
; IS__TUNIT____-NEXT:  entry:
; IS__TUNIT____-NEXT:    [[TMP:%.*]] = load i32, i32* @_ZL6test1g, align 4
; IS__TUNIT____-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP]], 0
; IS__TUNIT____-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; IS__TUNIT____:       if.then:
; IS__TUNIT____-NEXT:    store i32 0, i32* @_ZL6test1g, align 4
; IS__TUNIT____-NEXT:    br label [[IF_END]]
; IS__TUNIT____:       if.end:
; IS__TUNIT____-NEXT:    ret void
;
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@_Z7test1f1v()
; IS__CGSCC____-NEXT:  entry:
; IS__CGSCC____-NEXT:    [[TMP:%.*]] = load i32, i32* @_ZL6test1g, align 4
; IS__CGSCC____-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP]], 0
; IS__CGSCC____-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; IS__CGSCC____:       if.then:
; IS__CGSCC____-NEXT:    store i32 0, i32* @_ZL6test1g, align 4
; IS__CGSCC____-NEXT:    br label [[IF_END]]
; IS__CGSCC____:       if.end:
; IS__CGSCC____-NEXT:    ret void
;
entry:
  %tmp = load i32, i32* @_ZL6test1g, align 4
  %cmp = icmp eq i32 %tmp, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32* @_ZL6test1g, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

define i32 @_Z7test1f2v() nounwind {
; IS__TUNIT____: Function Attrs: nofree nosync nounwind readonly willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@_Z7test1f2v()
; IS__TUNIT____-NEXT:  entry:
; IS__TUNIT____-NEXT:    [[TMP:%.*]] = load i32, i32* @_ZL6test1g, align 4
; IS__TUNIT____-NEXT:    ret i32 [[TMP]]
;
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind readonly willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@_Z7test1f2v()
; IS__CGSCC____-NEXT:  entry:
; IS__CGSCC____-NEXT:    [[TMP:%.*]] = load i32, i32* @_ZL6test1g, align 4
; IS__CGSCC____-NEXT:    ret i32 [[TMP]]
;
entry:
  %tmp = load i32, i32* @_ZL6test1g, align 4
  ret i32 %tmp
}
