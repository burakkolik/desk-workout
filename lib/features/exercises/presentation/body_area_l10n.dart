import '../../../core/l10n/l10n.dart';
import '../../figure/domain/skeleton.dart';

extension BodyAreaL10n on BodyArea {
  String label(AppLocalizations l) => switch (this) {
    BodyArea.neck => l.areaNeck,
    BodyArea.shoulders => l.areaShoulders,
    BodyArea.upperBack => l.areaUpperBack,
    BodyArea.chest => l.areaChest,
    BodyArea.arms => l.areaArms,
    BodyArea.wrists => l.areaWrists,
    BodyArea.lowerBack => l.areaLowerBack,
    BodyArea.core => l.areaCore,
    BodyArea.hips => l.areaHips,
    BodyArea.hamstrings => l.areaHamstrings,
    BodyArea.quads => l.areaQuads,
    BodyArea.calves => l.areaCalves,
    BodyArea.ankles => l.areaAnkles,
  };
}
