(mapcar
  (function
    (lambda (el)
      (princ
	(strcat	"\t\tb_rez=ent_tp.isKindOf(AcGe::"		 el");\n"
		"\t\tif(b_rez==1) {acutPrintf(\"\\n\"); acutPrintf(\"" el"=%d\", b_rez); acutPrintf(\"\\n\");}\n\n"
       )
      )
    )
  )
  '("kEntity2d"		  "kEntity3d"		"kPointEnt2d"	      "kPointEnt3d"	    "kPosition2d"
    "kPosition3d"	  "kPointOnCurve2d"	"kPointOnCurve3d"     "kPointOnSurface"	    "kBoundedPlane"
    "kCircArc2d"	  "kCircArc3d"		"kConic2d"	      "kConic3d"	    "kCurve2d"
    "kCurve3d"		  "kEllipArc2d"		"kEllipArc3d"	      "kLine2d"		    "kLine3d"
    "kLinearEnt2d"	  "kLinearEnt3d"	"kLineSeg2d"	      "kLineSeg3d"	    "kPlanarEnt"
    "kPlane"		  "kRay2d"		"kRay3d"	      "kSurface"	    "kSphere"
    "kCylinder"		  "kTorus"		"kCone"		      "kSplineEnt2d"	    "kPolyline2d"
    "kAugPolyline2d"	  "kNurbCurve2d"	"kDSpline2d"	      "kCubicSplineCurve2d" "kSplineEnt3d"
    "kPolyline3d"	  "kAugPolyline3d"	"kNurbCurve3d"	      "kDSpline3d"	    "kCubicSplineCurve3d"
    "kTrimmedCrv2d"	  "kCompositeCrv2d"	"kCompositeCrv3d"     "kExternalSurface"    "kNurbSurface"
    "kTrimmedSurface"	  "kOffsetSurface"	"kEnvelope2d"	      "kCurveBoundedSurface"
    "kExternalCurve3d"	  "kExternalCurve2d"	"kSurfaceCurve2dTo3d" "kSurfaceCurve3dTo2d" "kExternalBoundedSurface"
    "kCurveCurveInt2d"	  "kCurveCurveInt3d"	"kBoundBlock2d"	      "kBoundBlock3d"	    "kOffsetCurve2d"
    "kOffsetCurve3d"	  "kPolynomCurve3d"	"kBezierCurve3d"      "kObject"		    "kFitData3d"
    "kHatch"		  "kTrimmedCurve2d"	"kTrimmedCurve3d"     "kCurveSampleData"    "kEllipCone"
    "kEllipCylinder"	  "kIntervalBoundBlock"	"kClipBoundary2d"     "kExternalObject"	    "kCurveSurfaceInt"
    "kSurfaceSurfaceInt"
   )
)



 ;|«Visual LISP© Format Options»
(130 2 5 2 nil "end of" 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
