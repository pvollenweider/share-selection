package org.jahia.modules;

import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.filter.AbstractFilter;
import org.jahia.services.render.filter.RenderChain;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.PropertyIterator;

public class ShareSelectionFilter extends AbstractFilter {
    private static final Logger logger = LoggerFactory.getLogger(ShareSelectionFilter.class);
    @Override
    public String execute(String previousOut, RenderContext renderContext, Resource resource, RenderChain chain) throws Exception {
        final JCRNodeWrapper node = resource.getNode();
        final PropertyIterator references = node.getWeakReferences("j:bindedComponent");
        while (references.hasNext()) {
            final Node selectionNode = references.nextProperty().getParent();
            if (selectionNode.isNodeType("jnt:shareSelection")) {
                logger.debug("Add selection section for " + selectionNode.getPath());
                return String.format("<div id=\"section_%s\">%s</div>", selectionNode.getIdentifier(), previousOut);
            }
        }
        return super.execute(previousOut, renderContext, resource, chain);
    }
}
