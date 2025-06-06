'use strict';

import { LogUtil } from '../LogUtil';

/*eslint no-console:0*/

/**
 * Supply a warning to the developer that a method they are using
 * has been deprecated.
 *
 * @param {string} method The name of the deprecated method
 * @param {string} [instead] The alternate method to use if applicable
 * @param {string} [docs] The documentation URL to get further details
 *
 * @returns {void}
 */
export default function deprecatedMethod(method, instead, docs) {
  try {
    LogUtil.warn(
      'DEPRECATED method `' + method + '`.' +
        (instead ? ' Use `' + instead + '` instead.' : '') +
        ' This method will be removed in a future release.');
    if (docs) {
      LogUtil.warn('For more information about usage see ' + docs);
    }
  } catch (e) { /* Ignore */ }
}
