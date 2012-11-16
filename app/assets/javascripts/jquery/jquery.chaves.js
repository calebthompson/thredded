// Generated by CoffeeScript 1.3.3
(function() {

  $.fn.extend({
    chaves: function(options) {
      var self;
      self = $.fn.chaves;
      options = $.extend({}, self.default_options, options);
      return $(this).each(function(i, el) {
        return self.init(el, options);
      });
    }
  });

  $.extend($.fn.chaves, {
    version: '0.1.0',
    default_options: {
      activeClass: 'active',
      bindings: [],
      childSelector: '> *',
      className: 'jquery-chaves',
      enableUpDown: false,
      helpModalClass: 'jquery-chaves-help',
      linkSelector: 'a:first',
      scope: 'all',
      searchSelector: '.search,\
                     #search,\
                     input[type="search"],\
                     input[type="text"][value*="earch"],\
                     input[type="text"][placeholder*="earch"]'
    },
    init: function(el, options) {
      var addToHelp, clickActive, downkeys, goDown, goUp, hideHelp, register_all_bindings, searchFocus, showHelp, upkeys,
        _this = this;
      this.options = options;
      this.bindings = $.extend([], options.bindings);
      this.el = $(el).addClass(options.className);
      this.children = this.el.find(options.childSelector);
      this.active = this.children.first().addClass(options.activeClass);
      this.index = 0;
      this.help = this.findOrCreateHelp();
      downkeys = 'j';
      upkeys = 'k';
      if (options.enableUpDown) {
        downkeys += ", down";
        upkeys += ", up";
      }
      register_all_bindings = function() {
        var binding, _i, _len, _ref, _results;
        _ref = _this.bindings;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          binding = _ref[_i];
          key(binding[0], _this.options.scope, binding[2]);
          _results.push(addToHelp(binding[0], binding[1]));
        }
        return _results;
      };
      addToHelp = function(keys, description) {
        return _this.help.find('dl').append("<dt>" + keys + "</dt><dd>" + description + "</dd>");
      };
      goUp = function() {
        var prev;
        if (_this.index > 0) {
          _this.index = _this.index - 1;
          prev = $(_this.children[_this.index]).addClass(_this.options.activeClass);
          _this.active.removeClass(_this.options.activeClass);
          _this.active = prev;
          return _this.readjust(150);
        }
      };
      goDown = function() {
        var next;
        if (_this.index < _this.children.length - 1) {
          _this.index = _this.index + 1;
          next = $(_this.children[_this.index]).addClass(_this.options.activeClass);
          _this.active.removeClass(_this.options.activeClass);
          _this.active = next;
          return _this.readjust(0);
        }
      };
      showHelp = function() {
        return _this.help.toggleClass('visible');
      };
      hideHelp = function() {
        return _this.help.removeClass('visible');
      };
      searchFocus = function() {
        _this.search = $(_this.options.searchSelector);
        return window.setTimeout((function() {
          return _this.search.focus();
        }), 10);
      };
      clickActive = function() {
        var link;
        link = _this.active.find(_this.options.linkSelector);
        if (link.trigger('click').attr('target') === '_blank') {
          return window.open(link.attr('href'), 'popped');
        } else {
          return window.location.href = link.attr('href');
        }
      };
      this.bindings.push([upkeys, 'Move selection up.', goUp]);
      this.bindings.push([downkeys, 'Move selection down.', goDown]);
      this.bindings.push(['shift+/', 'Toggle help dialog.', showHelp]);
      this.bindings.push(['esc, escape', 'Close help dialog.', hideHelp]);
      this.bindings.push(['/', 'Focus on search.', searchFocus]);
      this.bindings.push(['enter', 'Open/click element.', clickActive]);
      return register_all_bindings();
    },
    readjust: function(buffer) {
      var top;
      if (this.elementOutOfViewport(this.active[0])) {
        top = this.active.offset().top - buffer;
        return $(window).scrollTop(top).trigger('scroll');
      }
    },
    elementOutOfViewport: function(el) {
      var rect;
      if (el) {
        rect = el.getBoundingClientRect();
        return !(rect.top >= 0 && rect.left >= 0 && rect.bottom <= window.innerHeight && rect.right <= window.innerWidth);
      }
    },
    findOrCreateHelp: function() {
      var help, helpSelector;
      helpSelector = "." + this.options.helpModalClass;
      if (!$(helpSelector).length) {
        $('body').append("<div class=" + this.options.helpModalClass + "></div>");
        help = $(helpSelector).append('<h3>Keyboard Shortcuts</h3><dl></dl>');
      }
      return $(helpSelector);
    }
  });

}).call(this);
